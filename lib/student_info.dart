import 'API/api.dart';

final studentInfo = {
  '9876543211' : {
    'name' : 'Person 1',
    'password' : '123'
  },
  '9876543210' : {
    'password' : '123',
    'accounts' : [
      {
        'name' : 'John Doe',
        'std' : 'XII',
        'profileUrl' : 'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?semt=ais_hybrid&w=740'
      },
      {
        'name' : 'Aarav Sharma',
        'std' : "VII",
        'profileUrl' : "https://media.istockphoto.com/id/1388645967/photo/pensive-thoughtful-contemplating-caucasian-young-man-thinking-about-future-planning-new.jpg?s=612x612&w=0&k=20&c=Keax_Or9RivnYV_9VoOLjknWQP8iaxYXc4jS9rwBmcc="
      },
      {
        'name' : 'Anika Verma',
        'std' : 'IX',
        'profileUrl' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPaPdjB4sN-tnG2oKTFXcpZAv29cxBnsWvNI8RjlVI-zrNgz-W3CkkCVhv03Ubmu6P67U&usqp=CAU',
      },
      {
        'name' : 'Rohan Kapoor',
        'std' : 'V',
        'profileUrl' : 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?cs=srgb&dl=pexels-justin-shaifer-501272-1222271.jpg&fm=jpg',
      }
    ]
  }
};

final details = {
  0 : Data('Aarav Sharma',"https://media.istockphoto.com/id/1388645967/photo/pensive-thoughtful-contemplating-caucasian-young-man-thinking-about-future-planning-new.jpg?s=612x612&w=0&k=20&c=Keax_Or9RivnYV_9VoOLjknWQP8iaxYXc4jS9rwBmcc=","VII"),
  1 : Data('Anika Verma','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPaPdjB4sN-tnG2oKTFXcpZAv29cxBnsWvNI8RjlVI-zrNgz-W3CkkCVhv03Ubmu6P67U&usqp=CAU','IX'),
  2 : Data('Rohan Kapoor','https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?cs=srgb&dl=pexels-justin-shaifer-501272-1222271.jpg&fm=jpg','V')
};