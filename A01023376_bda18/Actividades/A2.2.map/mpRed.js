//1
var mapFunction1 = function() {
    emit(this.address.zipcode, 1);
  };
  var reduceFunction1 = function(zipcode, values) {
    return Array.sum(values);
  };
  db.restaurants.mapReduce(
    mapFunction1,
    reduceFunction1,
    {
      out:"numRestaurantsPerZipCode"
    }
  )
  //2
  var mapFunction2 = function() {
    emit(this.name, this.grades.length);
  };
  var reduceFunction2 = function(names, length) {
    return length[0];
  };
  db.restaurants.mapReduce(
    mapFunction2,
    reduceFunction2,
    {
      out:"gradesPerUser"
    }
  )
  
  //3
  
  var mapFunction3 = function() {
    this.grades.forEach((value)=>{
      emit(this.name, value.score);
    });
  };
  var reduceFunction3 = function(name, scores) {
    return Array.sum(scores);
  };
  db.restaurants.mapReduce(
    mapFunction3,
    reduceFunction3,
    {
      out:"scoresPerUser"
    }
  )
  
  //4
  
  var mapFunction4 = function() {
    if(this.grades.find(grade => grade.grade === 'A')) {
     emit('A', 1);
    }
    if(this.grades.find(grade => grade.grade === 'B')) {
     emit('B', 1);
    }
    if(this.grades.find(grade => grade.grade === 'C')) {
     emit('C', 1);
    }
  };
  var reduceFunction4 = function(key, value) {
     return Array.sum(value);
  };
  db.restaurants.mapReduce(
    mapFunction4,
    reduceFunction4,
    {
      out:"gotGradeABC"
    }
  )
  
  //5
  
  var mapFunction5 = function() {
    emit(this.cuisine, 1);
  };
  var reduceFunction5 = function(category, count) {
    return Array.sum(count);
  };
  db.restaurants.mapReduce(
    mapFunction5,
    reduceFunction5,
    {
      out:"restaurantsPerCategory"
    }
  )
  
  //6
  var mapFunction6 = function() {
    emit(this.name, );
  };
  var reduceFunction6 = function() {
    return
  };
  db.restaurants.mapReduce(
    mapFunction6,
    reduceFunction6,
    {
      out:"scoresPerUser"
    }
  )