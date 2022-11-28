const express = require('express');
const app = express();
const nodemon = require('nodemon');
app.use(express.json());

//MongoDB Package
const mongoose = require('mongoose');

const PORT = 1200;
let today = new Date().toLocaleDateString()

const dbUrl = "mongodb+srv://admin:admin@cluster0.ow9rs4z.mongodb.net/test";

//Connect to MongoDB
mongoose.connect(dbUrl, {
        useNewUrlParser: true,
        useUnifiedTopology: true
});

//MongoDB Connection
const db = mongoose.connection;

//Handle DB Error, display connection
db.on('error', () => (
    console.error.bind(console, 'connection error: ')
));
db.once('open', () => {
    console.log('MongoDB Connected');
});

//Schema/Model Declaration
require('./Models/Students');
require('./Models/Courses');

const Student = mongoose.model('Student');
const Course = mongoose.model('Course');

app.get('/', (req,res) => {
    return res.status(200).json("{message: OK}")
});

app.get('/getAllCourses', async (req,res) => {
    try {
        var programs = await Course.find({}).lean();
        return res.status(200).json({"programs" : programs});
    }
    catch {
        return res.status(500).json("{message: Failed to access course data}");
    }
});

app.get('/getAllStudents', async (req,res) => {
    try {
        let learners = await Student.find({}).lean();
        return res.status(200).json({"learners" : learners});
    }
    catch {
        return res.status(500).json("{message: Failed to access student data}");
    }
});

app.get('/findStudent', async (req,res) => {
    try {
        let learners = await Student.find({fname: req.body.fname}).lean();
        return res.status(200).json(learners);
    }
    catch {
        return res.status(500).json("{message: Unable to find}");
    }
});

app.get('/findCourse', async (req,res) => {
    try {
        let programs = await Course.find({courseID: req.body.courseID}).lean();
        return res.status(200).json(programs);
    }
    catch {
        return res.status(500).json("{message: Unable to find}");
    }
});

app.post('/addCourse', async (req,res) => {
    try {
        let program = {
            courseInstructor: req.body.courseInstructor,
            courseCredits: req.body.courseCredits,
            courseID: req.body.courseID,
            courseName: req.body.courseName,
            dateEntered: new Date()
        }

        await Course(program).save().then(c => {
            return res.status(201).json("Course Added!");
        })
    }
    catch {
        return res.status(500).json("{message: Failed to add course - bad data}");
    }
});

app.post('/addStudent', async (req,res) => {
    try {
        let learner = {
            fname: req.body.fname,
            lname: req.body.lname,
            studentID: req.body.studentID,
            dateEntered: new Date()
        }

        await Student(learner).save().then(c => {
            return res.status(201).json("Student Added!");
        })
    }
    catch {
        return res.status(500).json("{message: Failed to add student - bad data}");
    }
});

app.post('/editStudentById', async (req,res) => {
    try {
        let studentByID = await Student.updateOne({_id: req.body.id}, {
            fname: req.body.fname
        }, {upsert: true});

        if (studentByID)
            {
                res.status(200).json("{message: Student updated}");
            } else {
                res.status(200).json("{message: No student updated}");
            }
    }
    catch {
        return res.status(500).json("{message: Failed to edit student - bad data}");
    }
});

app.post('/editStudentByFname', async (req,res) => {
    try {
        let studentByFname = await Student.updateOne({fname: req.body.queryfname}, {
            fname: req.body.fname,
            lname: req.body.lname
        }, {upsert: true});

        if (studentByFname)
            {
                res.status(200).json("{message: Student updated}");
            } else {
                res.status(200).json("{message: No student updated}");
            }
    }
    catch {
        return res.status(500).json("{message: Failed to edit student - bad data}");
    }
});

app.post('/editCourseByCourseName', async (req,res) => {
    try {
        let CourseByCourseName = await Course.updateOne({courseName: req.body.courseName}, {
            courseInstructor: req.body.courseInstructor
        }, {upsert: true});

        if (CourseByCourseName)
            {
                res.status(200).json("{message: Course updated}");
            } else {
                res.status(200).json("{message: No course updated}");
            }
    }
    catch {
        return res.status(500).json("{message: Failed to edit course - bad data}");
    }
});

app.post('/deleteCourseById', async (req,res) => {
    try {
        let CourseDeleteById = await Course.findOne({courseID: req.body.courseID});

        if (CourseDeleteById)
            {
                await Course.deleteOne({courseID: req.body.courseID});
                res.status(200).json("{message: Course deleted}");
            } else {
                res.status(200).json("{message: No course deleted}");
            }
    }
    catch {
        return res.status(500).json("{message: Failed to delete course - bad data}");
    }
});

app.post('/removeStudentFromClasses', async (req,res) => {
    try {
        let StudentFromClasses = await Student.findOne({studentID: req.body.studentID});

        if (StudentFromClasses)
            {
                await Student.deleteOne({studentID: req.body.studentID});
                res.status(200).json("{message: Student deleted}");
            } else {
                res.status(200).json("{message: No student deleted}");
            }
    }
    catch {
        return res.status(500).json("{message: Failed to delete student - bad data}");
    }
});

app.listen(PORT, () => {
    console.log(`Server Started on port ${PORT}`);
});
