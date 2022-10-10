trigger updateforcast on User (before update) {
for (user targetUser : trigger.new){
targetUser.ForecastEnabled  = true; 
}

}