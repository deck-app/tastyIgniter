# TastyIgniter

> TastyIgniter is a developer-friendly, open source software solution that enables offline restaurants and takeaway businesses to engage with today’s online audience.

Fully customisable, developers can add their own extensions to the integrated marketplace, giving the restaurants they work with unrivalled access to the features and functionality they need to promote their brand, attract customers, and truly satisfy hungry bellies.

## Install

### Using DECK

Install tastyIgniter from the DECK marketplace and follow the instructions on the GUI

### From terminal with Docker

```
git clone https://github.com/deck-app/tastyIgniter.git
cd tastyIgniter
```

Edit `.env` file to change any settings before installing like php, apache versions etc

```
docker-compose up -d
```
### Modifying project settings
From the DECK app, go to stack list and click on project's `More > configure > Advanced configuration`
Follow the instructions below and restart your stack from the GUI

#### Rebuilding from terminal

You have to rebuild the docker image after you make any changes to the project configuration, use the snippet below to rebuild and restart the stack

```
docker-compose stop && docker-compose up --build -d
```
