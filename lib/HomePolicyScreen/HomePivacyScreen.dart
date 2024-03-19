import 'package:flockergym/Methods/colors_methods.dart';
import 'package:flockergym/NewBackend/DataCollectionBack/DataCollectionMethods.dart';
import 'package:flockergym/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePolicyScreen extends StatefulWidget {
  const HomePolicyScreen({super.key});

  @override
  State<HomePolicyScreen> createState() => _HomePolicyScreenState();
}

class _HomePolicyScreenState extends State<HomePolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 80, right: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Privacy Policy', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.sp),),
                        InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 130.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: lightyellow,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(child: Text('Back', style: TextStyle(color: darkgrey, fontWeight: FontWeight.bold),)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: silverdark,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 360.w,
                          child: Text('This Privacy Policy explains how we handle your information and your rights related to the information that we gather, apply, or share through:', style: TextStyle(color: Colors.white),)),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text('Our consumer-facing mobile application (“GymHub App”),', style: TextStyle(color: Colors.white),)),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Software Service: online business management software products from us', style: TextStyle(color: Colors.white),)),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Our pages on social media platforms', style: TextStyle(color: Colors.white),)),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Our apps that let you use the Software Service from Flocker Labs, such as the GymHub business apps', style: TextStyle(color: Colors.white),)),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('The HTML-formatted email messages we send you with this Privacy Policy’s link', style: TextStyle(color: Colors.white),)),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Any other products and services we offer through other places, websites and mobile apps that direct you to this Privacy Policy', style: TextStyle(color: Colors.white),)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: 360.w,
                          child: Text('By accessing or using the GymHub Services, you accept the terms and conditions of this Privacy Policy and acknowledge that this Privacy Policy informs you of the information we collect and how we use it as described below.', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('1. Defined TermsThe following terms will have the meanings indicated below. An “End User” is anyone who uses the GymHub Services, such as the GymHub App and other mobile apps, or who makes bookings, buys services and engages with our Subscribers through the GymHub Services.“Other Information” means any information that does not identify you or any other person, such as usage data that is not connected to any unique identifiers.“Personal Information” is data that is connected to or describes a natural person who is identified or can be identified, or, if relevant, a household as the law defines. This could be information like name, mailing address, phone number, email address, or unique online identifiers.A “Subscriber” is any company or organization that uses (or otherwise gets or uses) our Software Service, and any people who work for or with them, like staff, employees, consultants, advisors, or independent contractors, who use the GymHub Services for the Subscriber.In this Privacy Policy, we may use the word “information” to mean either Personal Information or Other Information.', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('2. Categories of Personal Information Depending on the type of GymHub Services that we provide or use and how we interact with people, the Personal Information we collect or get may include: How to contact you (e.g., name, address, email, phone number, and maybe emergency contact information from someone else), Who you are (e.g., birth date, education, nationality), Data from health and fitness trackers that measure your heart rate and other performance indicators, Data related to the GymHub Services (e.g., customer requests, statistics, etc.), Geolocation data with your consent (e.g. geolocation data from a mobile device), Images you upload to the GymHub Services, Online identifiers (e.g. IP address, Device IDs, etc.).', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('3. How We Collect Information Through the GymHub Services We collect information about you whenever you use the GymHub Services, for example: As an End User, you may need to give us Personal Information like your name, email and postal address, social media account ID, and Other Information when you make an account on the GymHub App or the GymHub Consumer Site(s). As an End User, you also give us Personal Information when you use the GymHub Services through a Subscriber, for example, to book an appointment, buy something, or join a marketing campaign. As a Subscriber, you need to give us your company name, address, phone number, email, credit card information, tax identification number, and other business information, as well as names and email addresses of people who can access your account, when you sign up for our Software Service. If you go to one of our events (e.g., a tradeshow, webinar, or training), we may ask for your feedback, contact details or other information to follow up with you, like sending you marketing messages based on your preferences. We gather information about you when you use the GymHub Services. We and our service providers get information about your location when you use or access GymHub Services. We collect and use this location-related data in order to Give you the services you have bought or asked for Show you content that matches your location Show you marketing or ad content that matches your location Prevent abuse or misuse of services or your account Make our site and services better It is not mandatory to give us some Personal Information, but we may not be able to offer the GymHub Service if you do not give or let us collect the required information. You claim that you have the right to do so and to allow us to use the information according to this Privacy Policy when you share any Personal Information about other people with us or our service providers through the GymHub Services.', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('4. How Personal Information May Be Used We may use your Personal Information for legitimate business purposes, including: To provide the functionality of GymHub Services and related support. To create, and administer accounts, fulfill and record transactions, and provide you with related assistance (e.g., technical help, answer inquiries relating to Personal Information, etc.). To send administrative information to you, for example, information regarding our services and changes to our terms, conditions, and policies. We will engage in these activities to manage our contractual relationship with you, with your consent, and/or to comply with a legal obligation. To provide you with marketing and promotional materials and opportunities and facilitate social sharing. To send you marketing communications and offer other materials that we believe may be of interest to you, such as to send you newsletters or other direct communications. To facilitate social sharing functionality if you choose to do so. For reporting and trending. To better understand you and our other users, so that we can tune and personalize our offering. For trending and statistics, and to improve our products and services.', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('5. What and How Personal Information May Be Disclosed Certain privacy laws require that we disclose certain information about the categories of Personal Information (as defined by applicable law) that we have disclosed for a business purpose as well as the categories that we have “sold” as defined under applicable law. Disclosed for a business purpose. In general, we may disclose the following categories of Personal Information (as described above in more detail) to our Partners and Service Providers to provide the GymHub services: Contact details, Personal details, Health and fitness tracker data collected from heart rate monitors and other performance monitoring activities,  Other GymHub Services related data,  Geolocation data,  Online identifiers, and Cookie-related data. We do not sell your data.', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('6. Privacy Rights regarding your Personal Information This section provides specific information for California residents, as required under California privacy laws, including the California Consumer Privacy Act (“CCPA”) as well as other jurisdictions and regulations that allow for individual privacy rights such as the European Economic Area, the United Kingdom, and the General Data Protection Regulation (“GDPR”). Explanation of Individual Rights Right to a Copy/Access or Portability: You may have the right to request, free of charge, a copy of the specific pieces of Personal Information that we have collected about you in a readily useable format that allows you to transmit this information to another entity without hindrance. Right to Know: You may have the right to request, free of charge, that we provide certain information about how we have handled your Personal Information, including the categories of Personal Information collected; categories of sources of Personal Information; business and/or commercial purposes for collecting your Personal Information; categories of third parties/with whom we have shared your Personal Information; and whether we sell any categories of Personal Information to third parties (however, we do not sell your Personal Information). Right to Deletion: You may have the right to request deletion of your Personal Information that we have collected, subject to certain exemptions. Please note that we may need to retain certain information for recordkeeping purposes and/or to complete any transactions that you began prior to requesting a change or deletion (e.g., when you make a purchase or enter a promotion, you may not be able to change or delete the Personal Information provided until after the completion of such purchase or promotion). We may also retain residual information, such as records to document that your request has been fulfilled. Right to Non-Discrimination: You may have the right not to receive discriminatory treatment on the basis of exercising your privacy rights under applicable law. Right to Correct/Rectify: You may have the right to rectify any incorrect Personal Information we may hold about you. Right to Object/Restrict: You may have the right to object to a specific use of your Personal Information as it is laid out in this Privacy Policy subject to our legitimate business interests. Submitting a Request Where applicable law allows for such a right, if you would like to request to access, correct, object to the use, restrict or delete Personal Information that you have previously provided to us, or if you would like to request to receive an electronic copy of your Personal Information for purposes of transmitting it to another company (to the extent this right to data portability is provided to you by applicable law), you may submit a request through the GymHub Services themselves or contact us at info@flockerlabs.com with the subject line "Data Subject Request". We will respond to your request consistent with applicable law. If you are an End User you may, depending on the GymHub Service utilized, be able to access, correct or request deletion of Personal Information that you have previously provided to us through your online customer account. These Data Subject Requests and other rights, including objection, restriction and portability (to the extent this right to data portability is provided to you by applicable law), can also be made directly to the relevant Subscriber. For your protection, we may only implement requests with respect to the Personal Information associated with the particular email address that you use to send us your request, and we may need to verify your identity before implementing your request. Where applicable law allows for an authorized agent to submit such a request, please contact us at info@flockerlabs.com with the subject line "Data Subject Request – Agent Request" and someone will be in touch with the agent and the End User to verify the request. We will try to comply with your request as soon as reasonably practicable. Moreover, where you are an End User, GymHub may need to forward your request and refer you to your Subscriber who may be better placed to address your request. If you are under 18 years of age and a user of the GymHub Services, you may also be entitled to ask us to remove content or information that you have posted to the GymHub Service by submitting a request on info@flockerlabs.com. Please note that your request does not ensure complete or comprehensive removal of the content or information if doing so infringes on the rights of another user. If you are an End User of one of our Subscribers and would no longer like to be contacted by one of our Subscribers, or would like request the exercise of a right as set out above in relation to Personal Information held by a Subscriber, please contact the Subscriber directly.', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('7. Your choices regarding our use and disclosure of information Except for health and fitness tracker data that is obtained via third parties, information we collect may be used by GymHub for marketing purposes such as one-off promotional emailing, mobile text messages, direct mail, and sales contacts. We give you many choices regarding our use and disclosure of your Personal Information for marketing purposes. You may: Opt-in or opt-out from receiving electronic communications from us: If you are a user of the GymHub App or the GymHub Consumer Site(s) and no longer want to receive marketing-related emails or mobile text messages from us on a going-forward basis, you may opt-out of receiving these marketing-related emails or mobile text messages by changing your preferences in your account settings or following the unsubscribe prompts from within the messages themselves. If you have provided your information to GymHub body, and opt-out, GymHub will put in place processes to honor your request. This may entail keeping some information for the purpose of remembering that you have opted-out. Consent to sharing of your Personal Information with unaffiliated third parties for their (or their customers’) direct marketing purposes: We only share your Personal Information with unaffiliated third-parties for their marketing purposes when you have consented to the sharing. We do not share data with unaffiliated third-parties in the absence of your consent and such consent will only be valid for a single data transfer. To address what these unaffiliated third-parties do with your data once you have consented to the sharing, please contact the third-party to learn more about your choices. We will try to comply with your request(s) as soon as reasonably practicable. Please also note that if you do opt-out of receiving marketing-related emails from us, we may still send you messages for administrative, transactional or other purposes directly relating to your use of the GymHub Services, and you cannot opt-out from receiving those messages. Our mobile applications may also send push notifications to your mobile device, provided you consented to this. If you have previously consented to receiving push notifications and no longer wish to receive them, you can also turn push notifications off at the device level. The applications may also request access to your device’s calendar application, storage, Bluetooth, camera, and microphone. If you have previously allowed access to your device’s calendar and no longer wish to allow access, you may edit the application settings at the device level.', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('8. Social Media Features and Widgests The GymHub Services includes social media features such as the Facebook Like button, and widgets, such as the Share This button or interactive mini-programs that run on our websites. These features may collect your IP address, which page you are visiting on our websites, and may set a cookie to enable the feature to function properly. Social media features and widgets are either hosted by a third party or hosted directly on our websites. Your interactions with these features are shared with such third parties and governed by the privacy policy of the company providing it.', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('9. Sign-In Services You can log in to some of the GymHub Services using sign-in services such as Facebook Connect, Google or an Open ID provider. These services will authenticate your identity and provide you the option to share certain Personal Information with us such as your name and email address to pre-populate our sign-up form. Some services like Facebook Connect give you the option to post information about your activities on our websites to your profile page to share with others within your network. In addition, when using some of our mobile applications we may allow you a chance to tell friends about our services by accessing the contacts in your Facebook or other social media account.', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('10. Testimonials, Ratings and Reviews If you submit testimonials, ratings or reviews to the GymHub Services, any Personal Information you include may be displayed in the GymHub Services. We also partner with service providers to collect and display ratings and review content on our web sites.', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('11. Data Retention We will retain your Personal Information for as long as needed or permitted in light of the purpose(s) for which it was obtained and consistent with applicable law. The criteria used to determine our retention periods include:The length of time we have an ongoing relationship with you and provide the GymHub Services to you (for example, for as long as you have an account with us or keep using the GymHub Services); Whether there is a legal obligation to which we are subject (for example, certain laws require us to keep records of your transactions for a certain period of time before we can delete them); or Whether retention is advisable in light of our legal position (such as in regard to applicable statutes of limitations, litigation or regulatory investigations).', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('12. Security of Your Information The security of Personal Information is a high priority at GymHub body. We seek to use reasonable technical, administrative and physical safeguards designed to protect Personal Information within our organization.', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('13. Use of Service By Miors The GymHub Services are not directed or targeted at children under the age of 16, and we request that they do not provide Personal Information through the GymHub Services.', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('14. Sensitive Information We ask that you not send us, and you not disclose, any sensitive Personal Information (e.g. information related to racial or ethnic origin, political opinions, religion or other beliefs, genetic characteristics, trade union membership or criminal background) on or through the GymHub Services or otherwise to us, except where explicitly requested or consented to.', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 20.h,),
                      SizedBox(
                          width: 340.w,
                          child: Text('15. Contact Us If you have any questions regarding this Privacy Policy you can contact us via email at info@flockerlabs.com', style: TextStyle(color: Colors.white),)),
                      SizedBox(height: 30.h,),
                    ],
                  ),
                ),
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: 80.h,
              //   color: Colors.black,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       InkWell(
              //         onTap: (){},
              //         child: Container(
              //           width: 130.w,
              //           height: 40.h,
              //           decoration: BoxDecoration(
              //             color: silverdark,
              //             borderRadius: BorderRadius.circular(5),
              //           ),
              //           child: Center(child: Text('I decline', style: TextStyle(color: lightyellow, fontWeight: FontWeight.bold),)),
              //         ),
              //       ),
              //       InkWell(
              //         onTap: (){
              //           Get.off(RouterScreen());
              //         },
              //         child: Container(
              //           width: 130.w,
              //           height: 40.h,
              //           decoration: BoxDecoration(
              //             color: lightyellow,
              //             borderRadius: BorderRadius.circular(5),
              //           ),
              //           child: Center(child: Text('I accept', style: TextStyle(color: darkgrey, fontWeight: FontWeight.bold),)),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        )
    );
  }
}
