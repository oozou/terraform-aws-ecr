# Change Log

All notable changes to this module will be documented in this file.

## [1.2.0] - 2023-12-15

### Added 

- Add resource `aws_ecr_lifecycle_policy`
- Add variables `is_create_lifecycle_policy` and `repository_lifecycle_policy`

### Changed

- Update example `.examples/complete` with lifecycle policy

## [1.1.0] - 2023-01-23

### Added

- Add locals `pre_event_pattern`, `greater_than_zero_pattern`, `severity_alert_options` and `event_pattern`
- Add modules `scan_eventbridge` to send alert to cloudwatch_event_target_arn
- Add outputs `aws_cloudwatch_event_rule_id` and `aws_cloudwatch_event_rule_arn`
- Add file event_pattern at `./templates/scan_event_pattern.json`
- Add variables `cloudwatch_event_target_arn` and `severity_alert_options`

### Changed

- Update example `.examples/complete` with alerting
- Update local from `prefix` to `name`
- Update variable naming from `repository_name` to `name`

## [1.0.3] - 2022-09-08

### Changed

- Update aws provider to version `>= 4.0.0`
- Rename file `ecr.tf` to `main.tf`

## [1.0.2] - 2022-07-19

### Added

- add encryption_configuration option for ecr
- add examples

## [1.0.1] - 2022-03-23

### Added

- Initial release for terraform-aws-ecr module.
