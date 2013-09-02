paper-gamification-website
==================

Gamifiy your paper writing experiences!

This is a visualization website of the statistics generated by the python script in my other repository: [paper-gamification](https://github.com/Kadrian/paper-gamification). The main part of the visualization is done with the help of HTML `<canvas>` and several [Processing.js](http://processingjs.org/) scripts.

## Installation

**1) Deployment**

At the moment, I use Heroku for deployment, but you should be able to deploy this app anywhere. For Heroku: clone this repository, register on [Heroku](https://www.heroku.com/) and follow their instructions on how to deploy a rails app.

**2) Setup**

* Create and migrate the database
* Insert at least one paper. For example via rails console on Heroku: 

`heroku run rails console`

`Paper.create :title => "The Flux-Compensator"`

* Use that so-created paper ID when starting the [paper-gamification](https://github.com/Kadrian/paper-gamification) python script.

## Contribution

Plese feel free to contribute! I'm rather new to open source publishing ;)
