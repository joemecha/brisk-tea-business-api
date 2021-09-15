# _BriskTea Business_

## About
BriskTea Business is a RESTful back-end API which exposes Tea Subscription data.


## Table of contents
[**Versions**](#versions) |
[**Project Design**](#project-design) |
[**Setup**](#setup) |
[**Endpoints**](#endpoints) |
[**Tests**](#running-the-tests) |
[**Developer**](#developer) |


## Versions
* Ruby 2.5.3
* Rails 5.2.5


## Project Design
![Diagram](lib/images/brisk-tea-business-api_diagram.jpeg "Project Design")


## Setup
If you are running this API locally, follow the steps below:
  1. Fork and clone this repo
  2. Install gem packages by running `bundle`
  3. Setup the database: `rails db:(drop,create,migrate,seed)` or `rails db:setup`
  4. Run command `rails s` and navigate to http://localhost:3000 to consume API endpoints below

<!-- If you are running the API via [Heroku](https://???.herokuapp.com/), simply consume endpoints below. -->

## Endpoints
The following are all API endpoints. Note, some endpoints have optional or required query parameters.

~ All endpoints run off base connector http://localhost:3000 ~ 


| Method   | URI                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `POST`   | `/api/v1/customer_subscriptions`         | Create a customer subscription.          |
| `PATCH`  | `/api/v1/customer_subscriptions/:id`     | Customer subscription to status 'cancelled'.  |
| `GET`    | `/api/v1/customer_subscriptions/:customer_id`     | Retrieve all subscriptions for a single customer.  |

#### Endpoint to subscribe a customer to a tea subscription:
POST `http://localhost:3000/api/v1/customers/:customer_id/subscriptions` 

body:
```
json 
{
    "tea_id": 5,
    "title": "Sidney's Subscription for Sobacha",
    "price": 1500,
    "frequency": 2
}
```

response: 
```
{
    "data": {
        "id": "7",
        "type": "subscription",
        "attributes": {
            "customer_id": 5,
            "tea_id": 5,
            "title": "Sidney's Subscription for Sobacha",
            "price": 1500,
            "frequency": "trimonthly",
            "status": "active"
        }
    }
}
```


#### Endpoint to cancel a customer’s tea subscription:
PATCH `http://localhost:3000/api/v1/customers/:customer_id/subscriptions/:id`

body:
```
json 
{
  "status": 0
}
```

response: 
```
{
    "data": {
        "id": "6",
        "type": "subscription",
        "attributes": {
            "customer_id": 1,
            "tea_id": 1,
            "title": "Benji's Subscription for Sencha,
            "price": 1500,
            "frequency": "trimonthly",
            "status": "cancelled"
        }
    }
}
```


#### Endpoint to see all of a customer’s subsciptions (active and cancelled):
GET `http://localhost:3000/api/v1/customers/:customer_id/subscriptions`

response: 
```
{
    "data": [
        {
            "id": "5",
            "type": "subscription",
            "attributes": {
                "customer_id": 5,
                "tea_id": 1,
                "title": "Sidney's Subscription for Xinyang Maojian",
                "price": 500,
                "frequency": "monthly",
                "status": "active"
            }
        },
        {
            "id": "7",
            "type": "subscription",
            "attributes": {
                "customer_id": 5,
                "tea_id": 5,
                "title": "Sidney's Subscription for Sobacha",
                "price": 1500,
                "frequency": "trimonthly",
                "status": "active"
            }
        }
    ]
}
```


## Running the Tests

Run all tests in application with `bundle exec rspec`. When test is complete, run `open coverage/index.html` to see where tests are being run and where they are not.


## Developer
### Joe Mecha  [GitHub](https://github.com/joemecha) • [LinkedIn](https://www.linkedin.com/in/joemecha/)
