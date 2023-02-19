// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"


import HelloController from "./hello_controller"
application.register("hello", HelloController)

// import NestedForm from 'stimulus-rails-nested-form'
// application.register('nested-form', NestedForm)

import NestedFormController from "./nested_form_controller"
application.register("nested-form", NestedFormController)
