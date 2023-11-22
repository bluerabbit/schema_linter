# frozen_string_literal: true

require 'spec_helper'

describe SchemaLinter do
  it 'has a version number' do
    expect(SchemaLinter::VERSION).not_to be nil
  end

  let(:schema_linter) { SchemaLinter.new }

  after { File.delete '.schema_linter.yml' if File.exists? '.schema_linter.yml' }

  describe '#error_table_names' do
    it do
      expect(schema_linter.error_table_names).to eq([])
    end

    context 'When a configuration file is present' do
      before do
        File.open '.schema_linter.yml', 'w' do |file|
          file.puts 'error_table_names:'
          file.puts '  - users'
        end
      end

      it 'finds error table names.' do
        expect(schema_linter.error_table_names).to eq(["users"])
      end
    end
  end

  describe '#error_column_names' do
    it 'Database columns that use reserved keywords will result in errors.' do
      expect(schema_linter.error_column_names).to eq(["users.role"])
    end

    context 'When a configuration file is present' do
      before do
        File.open '.schema_linter.yml', 'w' do |file|
          file.puts 'error_column_names:'
          file.puts '  - name'
        end
      end

      it 'finds error column names.' do
        expect(schema_linter.error_column_names).to eq(%w[users.name users.role])
      end
    end
  end
end
