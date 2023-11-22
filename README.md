# schema_linter

Welcome to the SchemaLinter gem! This tool ensures your database schema naming conventions are adhered to by checking both table names and column names against custom-defined rules in a YAML configuration file.

## Install

Put this line in your Gemfile:
```
gem 'schema_linter'
```

Then bundle:
```
% bundle
```


## Usage

Just run the following command in your Rails app directory.

```
% rake schema_linter
```

If you want the rake task to fail when errors are found.

```
% FAIL_ON_ERROR=1 rake schema_linter
```

## Configuration

Create a .schema_linter.yaml or .schema_linter.yml file in your root directory.

```yaml
error_table_names:
  - .*histories

error_column_names:
  - role
  - type
  - .*data
```

## Copyright

Copyright (c) 2023 Akira Kusumoto. See MIT-LICENSE file for further details.
