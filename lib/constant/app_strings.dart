import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


var firebaseAuth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;

String appName = "Travel Agency";

//FAQ english strings
const faqTitle1 = "How I can reached you";
const faqTitle2 = "Are there age restrictions on your trips?";
const faqTitle3 = "How safe are my belongings whilst on the trip?";
const faqTitle4 = "What type of vehicle do you use for travel?";
const faqTitle5 =
    "What if someone who is traveling shows symptoms of COVID-19?";
const faqDescription1 =
    "The beauty of travel is that it’s accessible to everyone, in some form. Even, You don't have to go far to experience a new culture. In your country, people of different religions, different races, and different ethnicities are living with you. You don't have to be rich to see how they live, their language, food, culture, etc. But you must keep a budget.This budget will also depend on what you want to see and what services your agency will offer you ";

const faqDescription2 =
    "For the majority of our trips, the minimum age is 15. An adult must accompany all children under the age of 18. Younger children can join us on our Family trips and Short Break Adventures. Most of our trips don’t have a maximum age limit, but a Self-Assessment Form is required for all passengers 70 years and over.";

const faqDescription3 =
    "While we take all the precautions we can to make sure your belongings are safe, we are traveling to some exciting destinations that are sometimes home to some pretty skilled thieves. Travel insurance is a must and a lockable bag or money belt will always help too.";

const faqDescription4 =
    "The type of transport used depends on your trip style. Find out more or see your Essential Trip Information for the specific type of transportation used on your journey.";

const faqDescription5 =
    "If a customer feels unwell during their trip, our Intrepid Leader will assist them to access medical care. This may include facilitating COVID-19 testing if requested by the customer and we also encourage customers to bring their own RAT tests from home as a precaution.";




//add tour package screen
const adPackageMessageEng =
    "We are always in service.  Please feel free for any queries.";


//support screen
const supportMessageEng =
    "Thank you for being with us. You are requested to contact us if there is any trouble.";

//privacy policy
const introEng =
    "We are committed to protecting the privacy of our users. This Privacy Policy explains how we collect, use, and protect the personal information of our users.";


const headingEng = "Information We Collect:";

const title1Eng = "•	Personal information: ";
const desc1Eng =
    "We collect personal information such as name, email address, and phone number when users create an account or book a tour.";

const title2Eng = "•	Usage data: ";
const desc2Eng =
    "We also collect information about how users interact with our app, such as their location, search history, and tour bookings.";

const title3Eng = "•	To provide and improve our services: ";
const desc3Eng =
    "We use the information we collect to process tour bookings, send confirmation emails, and contact users about their bookings.";

const title4Eng = "•	To personalize the user's experience: ";
const desc4Eng =
    "We use usage data to understand how users interact with our app and to personalize the content and tours that we recommend to them.";

const title5Eng = "•	To send marketing materials: ";
const desc5Eng =
    "We may also use your personal information to send promotional emails and other marketing materials.";

const title6Eng = "•	Data Protection:";
const desc6Eng =
    "We use encryption to protect data in transit and at rest, and implement access controls to prevent unauthorized access to user data.We also comply with all relevant laws and regulations regarding data protection and privacy.";

const title7Eng = "•	Sharing of Personal Information:";
const desc7Eng =
    "We use encryption to protect data in transit and at rest, and implement access controls to prevent unauthorized access to user data.We also comply with all relevant laws and regulations regarding data protection and privacy.";

const title8Eng = "•	Accessing and Updating Personal Information:";
const desc8Eng =
    "Users can access and update their personal information at any time by logging into their account.If you have any questions or concerns about your privacy, please contact us at [email/phone number].";

const conclusionEng =
    "By using our app, you consent to our collection, use, and protection of your personal information as outlined in this Privacy Policy. We reserve the right to make changes to this policy at any time, and continued use of our app will be considered acceptance of any changes.";

