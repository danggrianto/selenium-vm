@test "selenium-server should exist" {
      test -f /opt/local/selenium_grid/selenium-server-standalone-2.43.0.jar 
}

@test "selenium-server hub should run" {
      supervisorctl status | grep hub | grep RUNNING
}
