import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:videoplayer/colors.dart';
import 'package:videoplayer/view/screens/video_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List info=[];

 initdata()async{
 await DefaultAssetBundle.of(context).loadString('json/info.json').then((value) {
  setState(() {
    info=  json.decode(value);
  });
  });
}

  @override
  void initState() {
   
    super.initState();
    initdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.homePageBackground ,
      body: Container(
        padding: EdgeInsets.only(
          left: 20,
          top: 30,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Training',
                style: TextStyle(
                  color: AppColor.homePageTitle,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                
                ),
                ),
                Expanded(child: Container()),
                Icon(Icons.arrow_back_ios),
                SizedBox(width: 10,),
                Icon(Icons.calendar_month),
                 SizedBox(width: 10,),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            SizedBox(height: 10,),

            Row(
              children: [
                Text('Your programme',
                style: TextStyle(
                  color: AppColor.homePageSubtitle,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  
                ),),
                Expanded(child: Container()),
                TextButton(onPressed: (){
                  Get.to(Video_page());
                },
                 child: Text('Details',
                 style: TextStyle(
                  color: AppColor.homePageDetail,
                  fontSize: 15,
                  

                 ),)),
                 Icon(Icons.arrow_forward,
                 color: AppColor.homePageIcons,
                 size: 15,
                 )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
               gradient: LinearGradient(colors: 
               [
                AppColor.gradientFirst,
                AppColor.gradientSecond,
               ]),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(70),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),

                )
              ),
              child: Container(
                   padding: EdgeInsets.only(
                    left: 20,
                    top: 10,
                   ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Next workout',
                    style: TextStyle(
                      color: AppColor.homePageContainerTextSmall,
                        fontSize: 15,
                         fontWeight: FontWeight.w400,
                      
                    ),
                    ),
                    SizedBox(height: 10,),
                       Text('Legs Toning',
                    style: TextStyle(
                      color: AppColor.homePageContainerTextBig,
                        fontSize: 20,
                         fontWeight: FontWeight.w500,
                         
                      
                    ),
                    ),
                       Text('and Glutes Workout',
                    style: TextStyle(
                      color: AppColor.homePageContainerTextBig,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      
                    ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        Icon(Icons.timer,
                        color: AppColor.secondPageIconColor,
                        ),
                        SizedBox(width: 10,),
                        Text('60min',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                         color: AppColor.homePageContainerTextSmall,

                        ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          margin: EdgeInsets.only(
                            right: 20,
                            
                          ),
                         height: 50,
                         width: 50,
                         decoration: BoxDecoration(
                          color: AppColor.homePageBackground,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                               blurStyle: BlurStyle.outer,
                               blurRadius: 10,
                            )
                          ]
                         ),
                         child: Icon(Icons.play_arrow),
                        )
                      ],
                    )
                  ],
                ),
              ),

            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 140,
             
             decoration: BoxDecoration(
             
              borderRadius: BorderRadius.circular(20,),
            

             ),
             child: Stack(
              children: [
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                 margin: EdgeInsets.only(top: 20,),
                  decoration: BoxDecoration(
                 
                    image: DecorationImage(image: AssetImage('Assets/card.jpg'),
                    fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        offset: Offset(8, 10),
                        color: AppColor.gradientSecond.withOpacity(0.3)
                      )
                    ]

                  ),
                ),
                Container(

                  height: 200,
                  width: 350,
                 margin: EdgeInsets.only(
                  right: 200,
                  bottom: 30,
                  

                 ),
                 
                  decoration: BoxDecoration(
                   

                    image: DecorationImage(
                     
                      image: AssetImage('Assets/figure.png'),
                    )
                  ),
                 ),
                 Container(
                  height: 100,
                  width: double.maxFinite,
                  
                  margin: EdgeInsets.only(left: 140,

                  top: 30
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('You are doing great',
                      style: TextStyle(
                        color: AppColor.secondPageContainerGradient1stColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,

                      ),),
                       Text('Keeep it up',
                      style: TextStyle(
                        color: AppColor.homePagePlanColor,
                      
                        fontWeight: FontWeight.w600,

                      ),),
                       Text('You are doing great',
                      style: TextStyle(
                        color: AppColor.homePagePlanColor,
                      
                        fontWeight: FontWeight.w600,

                      ),)
                    ],
                  ),
                 )


              ],
             ),
            ),
            SizedBox(
              height: 10,
            ),
              Text('Area of focus',
                style: TextStyle(
                  color: AppColor.homePageSubtitle,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  
                ),),

                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: GridView.builder(
                    itemCount: info.length,
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
               
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  
                  ) ,
                   itemBuilder: (context, index) {

                    
                     return  Container(
                         padding: EdgeInsets.all(20),
                         margin: EdgeInsets.only(
                         ),
                          height: MediaQuery.of(context).size.height,
                          width:MediaQuery.of(context).size.width ,

                          decoration: BoxDecoration(
                            color: Colors.white,
                           image: DecorationImage(image: AssetImage(info[index]['img'],)),
                             boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: AppColor.gradientSecond.withOpacity(0.1),
                                offset: Offset(5, 5),


                              ),
                               BoxShadow(
                                blurRadius: 3,
                                color: AppColor.gradientSecond.withOpacity(0.1),
                                offset: Offset(-5, -5),


                              )
                             ]        
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: 110,
                            left: 50
                            ),
                            child: Text(info[index]['title'],
                            style: TextStyle(
                              color: AppColor.gradientFirst,
                              fontSize: 15,


                            ),
                            ))              
                        );
                   },)
                )



            
          ],
        ),
      ),
    );
  }
}