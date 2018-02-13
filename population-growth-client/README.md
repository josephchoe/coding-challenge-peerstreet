# PopulationGrowthClient

A population growth client that connects to the endpoint: http://production.ei5pmnpwgf.us-east-1.elasticbeanstalk.com/census

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'population_growth_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install population_growth_client

## Usage

Query a zip code:

    PopulationGrowthClient::Client.new.get(zip_code: '00001')

Use your own enpdpoint:

    PopulationGrowthClient::Client.new(url: 'http://path/to/endpoint').get(zip_code: '00001')
