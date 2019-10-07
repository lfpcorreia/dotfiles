# Tree Pruning

## The setup

We are gonna sell to our clients a service that fetches population data from an upstream API. Our service will have to fetch data from the upstream, parse it, filter it if required and finally return the data back.

Unfortunately the upstream service could have been better implemented.. it doesn't behave to the upmost standards when it comes to a Restful API: sometimes it breaks for no good reason, has no pride in what it's returning..

It's our job to wrap it and make our uttermost picky clients happy about information sharing on the web!

## The problem

We want to serve our clients with an admirable service: fetch, filter and properly return a bunch of KPIs from the ugly upstream service.

The upstream spills out something that could be interpreted as an _application/json_ response and (thank god!) they shared a status code! Just don't assume it will always return the same data, has the KPIs can be updated somewhere in the future, so no luck caching it..

We've noticed it doesn't always return a 200 status. In that case we should not let our clients down! We must keep on trying before (eventually) tell our clients the data is unavailable.

## The data

The upstream lives at http://core-alb-1458074199.eu-west-1.elb.amazonaws.com:7777/ and in order to fetch what we need we must do a *GET* request to the */data* endpoint.

The upstream answers (sometimes.. anyway..) a tree displayed in JSON format composed of Themes, Sub-themes and Categories. It's quite a mess for the average developer, but the way the KPIs are organized make all the sense for a demographics geek!


## The challenge

You should make an *API* with only one endpoint, */demographics/\<name\>*.

This endpoint receives the name of the endpoint that is to be requested to the upstream and a bunch of *GET* parameters: *kpi_ids[]*. The parameters are the *IDs* of the KPIs you're supposed to filter for. Whenever a requested KPI id is matched in the upstream data the full subtree must be returned.

If too many attempts result in unavailability from the upstream return a 500.
And, if the name of the requested endpoint isn't available in the upstream return a 404.

Take the following as an example:

```
$ curl -v 'http://127.0.0.1:5000/demographics/data?indicator_ids\[\]=31&indicator_ids\[\]=32&indicator_ids\[\]=1'
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to 127.0.0.1 (127.0.0.1) port 5000 (#0)
> GET /tree/input?indicator_ids[]=31&indicator_ids[]=32&indicator_ids[]=1 HTTP/1.1
> Host: 127.0.0.1:5000
> User-Agent: curl/7.52.1
> Accept: */*
>
* HTTP 1.0, assume close after body
< HTTP/1.0 200 OK
< Content-Type: application/json
< Content-Length: 1018
< Server: Werkzeug/0.12.2 Python/3.6.1
< Date: Mon, 10 Jul 2017 11:01:15 GMT
<
[
  {
    "id": 2,
    "name": "Demographics",
    "sub_themes": [
      {
        "categories": [
          {
            "id": 11,
            "indicators": [
              {
                "id": 1,
                "name": "total"
              }
            ],
            "name": "Crude death rate",
            "unit": "(deaths per 1000 people)"
          }
        ],
        "id": 4,
        "name": "Births and Deaths"
      }
    ]
  },
  {
    "id": 3,
    "name": "Jobs",
    "sub_themes": [
      {
        "categories": [
          {
            "id": 23,
            "indicators": [
              {
                "id": 31,
                "name": "Total"
              },
              {
                "id": 32,
                "name": "Female"
              }
            ],
            "name": "Unemployment rate, 15\u201324 years, usual",
            "unit": "(percent of labor force)"
          }
        ],
        "id": 8,
        "name": "Unemployment"
      }
    ]
  }
]
* Curl_http_done: called premature == 0
* Closing connection 0
```

## What we will be looking for

The implementation is completely up to you! As long as it's in Python! :) You can go full vanilla or use your preferred Python framework. As long as it works and a set of clear instructions on how to get it to work are included!

Your solution can be one of the following:
- just a bunch of files
- a git repo
- a Docker image.

We'll be on evaluating:
- Code structure
- Readability
- Tests
- How you deal with edge cases


