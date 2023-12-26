#!groovy

import hudson.security.csrf.DefaultCrumbIssuer
import jenkins.model.Jenkins

println "--> Enabling CSRF Protection"

def instance = Jenkins.instance
instance.setCrumbIssuer(new DefaultCrumbIssuer(true))
instance.save()
