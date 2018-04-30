//1. Aggregate
db.grades.aggregate([{$group : {_id: "$student_id"}}, {$count: "Students"}])

//1. ReduceMap
var map = function(){
    emit(1, {sum: this.student_id, count: 1});
}

var reduce = function(k, vals){
    var sum = vals[0];
    for (var i=1; i<vals.length; i++){
        var b = vals[i];
        a.sum+=b.sum;
    }
    return a;
};

db.grades.aggregate(map, reduce, {out:"Students: "})

//2
db.grades.aggregate([{$group : {_id: "$class_id"}}, {$count: "Courses"}])

//3
db.grades.aggregate([{$unwind : "$scores"}, {$group : {_id: "$student_id", score: {$avg: "$scores.score"}}}])

//4
db.grades.aggregate([{$unwind : "$scores"}, {$group : {_id: {'class_id':'$class_id', 'student_id':'$student_id', 'score': {$min: "$scores.score"}}}}, {$sort : {score : 1}}, {$limit : 1}])

//5
db.grades.aggregate([{$unwind : "$scores"},{$match:{"scores.type":'homework'}},{$group:{_id: "$class_id",homework: {$sum: 1}}},{"$sort":{homework : -1}},{"$limit":1}]);

//6
db.grades.aggregate([{$group:{_id: {'Student_id' : "$student_id", "courses": {$count:"courses"}}}}, {$sort:-1}, {$limit :1}]);
db.grades.aggregate([{$group : {_id: {'Student_id' : "$student_id", "courses": "$class_id"}}}, {$count: "Student_id"}, {$sort:-1}, {$limit :1}])
//7
db.grades.aggregate([{$unwind : "$scores"},{$group:{_id: {student:"$student_id", class:"$class_id"},avg: {$avg: "$scores.score"}}},{$match:{"avg":{"$lt":60}}},{$group:{_id:"$_id.class",count:{$sum: 1}}},{"$sort":{'count':-1}},{"$limit":1}]);
