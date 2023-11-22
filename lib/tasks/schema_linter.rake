desc 'Perform schema linting and output error table and column names. Raise an error if FAIL_ON_ERROR is set and there are errors.'
task schema_linter: :environment do
  schema_linter = SchemaLinter.new

  error_table_names = schema_linter.error_table_names
  if error_table_names.present?
    puts "Error table names (#{error_table_names.size}):"
    error_table_names.each { |table_name| puts "  #{table_name}" }
  end

  error_column_names = schema_linter.error_column_names
  if error_column_names.present?
    puts "Error column names (#{error_column_names.size}):"
    error_column_names.each { |column_name| puts "  #{column_name}" }
  end

  if ENV['FAIL_ON_ERROR'] && (error_table_names.present? || error_column_names.present?)
    raise 'Error detected.'
  end
end
