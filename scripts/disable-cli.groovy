#!groovy

import jenkins.model.Jenkins

Jenkins jenkins = Jenkins.getInstance()

println "--> Disabling Jenkins Remote CLI"
jenkins.CLI.get().setEnabled(false)
jenkins.save()
