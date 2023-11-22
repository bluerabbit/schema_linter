# schema_linter

This tool inspects whether the database schema contains any reserved words from MySQL or PostgreSQL, or any table names and column names that should not be used in Rails. Furthermore, 
it allows for the definition of custom settings using custom definition rules in the YAML configuration file.

## Installation

Add this line to your Gemfile:
```
gem 'schema_linter'
```

Then run:
```
% bundle
```

## Usage

Simply execute the following command in your Rails app directory.

```
% rake schema_linter
```

If you want the rake task to fail when it encounters errors, use:

```
% FAIL_ON_ERROR=1 rake schema_linter
```

## Configuration

Create a `.schema_linter.yaml` or `.schema_linter.yml` file in your root directory.

To flag specific tables as errors, list them with regular expressions under `error_table_names`.
To flag specific columns as errors, list them with regular expressions under `error_column_names`.

```yaml
error_table_names:
  - .*histories$
  - .*info$

error_column_names:
  - .*data$
```

To exclude specific tables from the checks, list them with regular expressions under ignore_table_names.
To exclude specific columns from the checks, list them with regular expressions under ignore_column_names.

```yaml
ignore_table_names:
  - ^user$

ignore_column_names:
  - ^role$
```

## Copyright

Copyright (c) 2023 Akira Kusumoto. See MIT-LICENSE file for further details.
