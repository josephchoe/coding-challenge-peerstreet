# README

This is the repository for the population-growth-api.

## ETL

I've uploaded the provided CSV files to an S3 bucket. Importing them can be done via `bundle exec rake import:census`.

## Endpoint

http://production.ei5pmnpwgf.us-east-1.elasticbeanstalk.com/census?zip_code={zip_code}
