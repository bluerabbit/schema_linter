class SchemaLinter
  VERSION = Gem.loaded_specs['schema_linter'].version.to_s

  class Railtie < ::Rails::Railtie
    rake_tasks do
      load File.join(File.dirname(__FILE__), "tasks/schema_linter.rake")
    end
  end

  def initialize
    @error_table_names            = (config["error_table_names"] || [])
    @error_column_names           = (config["error_column_names"] || [])
    @rails_reserved_table_names   = load_keywords('lib/rails_avoid_tables.txt')
    @rails_reserved_column_names  = load_keywords('lib/rails_avoid_columns.txt')
    @postgresql_reserved_keywords = load_keywords('lib/postgresql_keywords.txt')
    @mysql_reserved_keywords      = load_keywords('lib/mysql_keywords.txt')
  end

  def error_table_names
    table_names = models.map(&:table_name)
    table_names.filter do |table_name|
      table_name_has_errors?(table_name)
    end
  end

  def error_column_names
    models.each.with_object([]) do |model, error_columns|
      column_names = model.columns.map(&:name)

      column_names.each do |column_name|
        if column_name_has_errors?(column_name)
          error_columns << "#{model.table_name}.#{column_name}"
        end
      end
    end
  end

  private

  def config_filename
    %w[.schema_linter.yaml .schema_linter.yml].detect { |f| File.exist?(f) }
  end

  def config
    @config ||= config_filename ? YAML.load_file(config_filename) : {}
  end

  def models
    return @models if @models

    @models ||= ActiveRecord::Base.descendants.reject(&:abstract_class).reject do |_model|
      # TODO: ignore_models
      # @ignore_models.include?(model.name) || @ignore_tables.include?(model.table_name)
    end
  end

  def table_name_has_errors?(table_name)
    name = table_name.downcase
    @error_table_names.include?(name) ||
      @mysql_reserved_keywords.include?(name) ||
      @postgresql_reserved_keywords.include?(name) ||
      @rails_reserved_table_names.include?(name)
  end

  def column_name_has_errors?(column_name)
    name = column_name.downcase
    @error_column_names.include?(name) ||
      @mysql_reserved_keywords.include?(name) ||
      @postgresql_reserved_keywords.include?(name) ||
      @rails_reserved_column_names.include?(name)
  end

  def load_keywords(file_path)
    File.readlines(file_path).map(&:strip).map(&:downcase)
  end
end
