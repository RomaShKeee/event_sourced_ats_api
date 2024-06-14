# Applicant Tracking System (ATS) with Event Sourcing

This project is a simple Applicant Tracking System (ATS) that uses Event Sourcing to manage the status of both jobs and applications. The system allows HR managers to track which candidates have applied to positions, the status of each application, and add notes about applicants. 

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
- [Event Sourcing](#event-sourcing)
- [Projections](#projections)
- [Testing](#testing)

## Requirements

- Ruby 3.2.2 or later
- Rails 7.0 or later
- PostgreSQL
- Bundler

## Installation

1. Clone the repository:

2. Install the dependencies:
  
  ```sh
  bundle install
  ```

3. Set up the database:

  ```sh
  bundle exec rails db:create db:migrate db:seed
  ```

4. Start the Rails server:
  ```sh
  bundle exec rails s
  ```

## Usage
### API Endpoints
### Jobs
List all jobs

```sh
GET /v1/jobs?page=1&items=10
```

Response:

```json

{
  "pagy": { /* pagination details */ },
  "jobs": [
    {
      "name": "Software Engineer",
      "status": "activated",
      "hired_count": 1,
      "rejected_count": 0,
      "ongoing_count": 1
    },
    // other jobs...
  ]
}
```

### Applications
List all applications for activated jobs

```sh
GET /v1/applications?page=1&items=10
Response:
```

```json
{
  "pagy": { /* pagination details */ },
  "applications": [
    {
      "job_name": "Software Engineer",
      "candidate_name": "John Doe",
      "status": "hired",
      "notes_count": 0,
      "interview_date": "2023-01-15"
    },
    // other applications...
  ]
}
```

## Event Sourcing
This system uses event sourcing to manage the status of jobs and applications. The status is calculated based on events rather than being stored directly in the model. This allows for a historical record of all changes to the status.

## Projections
Projections are used to calculate the current state of jobs and applications based on their events. The projections ensure that the system adheres to the principles of CQRS (Command Query Responsibility Segregation).

## Testing
RSpec is used for testing the system. To run the tests, execute:

```sh
bundle exec rspec
```

This will run the full test suite, including tests for models, controllers, and projections.

