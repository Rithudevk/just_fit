import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer/colors.dart';


class Video_page extends StatefulWidget {
  const Video_page({super.key});

  @override
  State<Video_page> createState() => _Video_pageState();
}

class _Video_pageState extends State<Video_page> {
   
   
  bool _isplaying =false;
  bool playarea=false;
  List info=[];
   VideoPlayerController ?_controller;
  var _isplayingIndex=-1;
  bool dispos =false;
  
 initdata()async{
 await DefaultAssetBundle.of(context).loadString('json/video_info.json').then((value) {
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
  void dispose() {
   dispos=true;
   _controller?.pause();
   _controller?.dispose();
   _controller=null;
    super.dispose();
  }
  var _onupdatecontrollertime;
  void _listercontroller()async{
    if(dispos){
      return;
    }
    _onupdatecontrollertime=0;
    final now=DateTime.now().microsecondsSinceEpoch;
    if(_onupdatecontrollertime>now){
      return;
    }
    _onupdatecontrollertime=now+500;

    final controller=_controller;
    if(controller==null){
      return debugPrint('controller is null');
    }if(!controller.value.isInitialized){
      return debugPrint('controller not initizilised');
    }
    final playiing=controller.value.isPlaying;
    _isplaying=playiing;


  }
  _isinitialisevideo(int index){
     final controller=VideoPlayerController.networkUrl(Uri.parse(info[index]['videoUrl']));
     final old=_controller;
     _controller=controller; 
     if(old!=null){
      old.removeListener(_listercontroller);
      old.pause();
     }
      
      controller.addListener(_listercontroller);
      setState(() {
        
      });
    controller..initialize().then((_) {
      old?.dispose();
      setState(() {
        
      });
       _isplayingIndex=index;
       
      controller.play();

    });
  }

  _ontapVideo(int index){
   _isinitialisevideo(index);

  }

  Widget playview(BuildContext ctx)  {

   
    final controller=_controller;
   
    if(controller!=null && controller.value.isInitialized){
      
      return Container(
       padding: EdgeInsets.only(bottom: 10,),
          height: 180,
          width: 325,
           child: AspectRatio(
        
          aspectRatio: 16/9,
          child: VideoPlayer(controller), ),
      );
      
       }else{
      return  AspectRatio(
          aspectRatio: 16/9,
          child: Center(child: Text('Preparing...',
          style: TextStyle(
            fontSize: 20,
            color: Colors.greenAccent,

          ),
          )));
      
    }
    
  }
  Widget controllview(BuildContext context){
    final nomute=(_controller?.value.volume??0)>0;
    return  Row(
                   children: [
                    
                  GestureDetector(
                    
                    onTap: () {
                      
                      if(nomute){
                        _controller?.setVolume(0);
                      }else{
                        _controller?.setVolume(1.0);
                      }
                      setState(() {
                        
                      });
                    },
                    child:   Container(
                  
                    margin: EdgeInsets.only(
                      left: 30,
                      top: 10,

                    ),
                      child:nomute? Icon(Icons.volume_up,
                      size: 30,
                      ):Icon(Icons.volume_off_outlined)
                      
                    ),
                  ),

                     Container(
                     
                      margin: EdgeInsets.only(
                         top: 10,

                        left: 70,
                       
                      ),
                     
                      child: Row(
                        children: [
                         GestureDetector(
                          onTap: () async{
                            final index=_isplayingIndex-1;
                            if(index>=0&&info.length>=0){
                              _isinitialisevideo(index);
                            }else{
                              Get.snackbar('Message', 'No more video to play ',
                              backgroundColor: Colors.greenAccent
                              );
                            }
                            
                          },
                          child:  Icon(CupertinoIcons.backward_fill,
                          size: 30,
                          ),
                         ),
                          SizedBox(width: 20,),
                         GestureDetector(
                          onTap: ()async {
                           if(_isplaying){
                           setState(() {
                              _controller?.pause();
                           });
                     
                           } else{
                           setState(() {
                              _controller?.play();
                           });
                           }
                          },
                          child:  Icon(_isplaying?Icons.pause:
                           Icons.play_arrow,
                          size: 30,),
                         ),
                         
                          SizedBox(width: 20,),
                          GestureDetector(
                            onTap: ()async {
                              final index=_isplayingIndex+1;
                              if(index<=info.length-1){
                                _isinitialisevideo(index);
                     
                              }else{
                                Get.snackbar('Message', 'you complete all videos in the list Congrats!! ',
                              backgroundColor: Colors.greenAccent
                              ); 
                              }
                            },
                            child:  Icon(CupertinoIcons.forward_fill,
                          size: 30,
                          ),
                          )
                        ],
                      ),
                     ),
                   ],
                 );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
      
        height: double.infinity,
        width: double.infinity,
        decoration:playarea==false? BoxDecoration(
          gradient: LinearGradient(colors:[
            AppColor.secondPageContainerGradient1stColor,
            AppColor.secondPageContainerGradient2ndColor,
          ])
        ):BoxDecoration(color: Colors.white),
        child:Stack(
          children: [
       playarea==false? Container(
              margin: EdgeInsets.only(
                right: 20,
                left: 20,
                top: 40,

              ),
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
          gradient: LinearGradient(colors:[
            AppColor.secondPageContainerGradient1stColor,
            AppColor.secondPageContainerGradient2ndColor,
          ])
        ),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
           Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back_ios,
                color: AppColor.secondPageTopIconColor,
                
                ),
              ),
              Spacer(),
              Icon(Icons.info,
              color: AppColor.secondPageTopIconColor,
              )
            ],
           ) ,
           SizedBox(
            height: 40,
           ),
           Text('Legs Toning',
           style: TextStyle(
            color: AppColor.secondPageTitleColor,
            fontSize: 30,
            fontWeight: FontWeight.w500,
           ),
           ),
           Text('and glutes workout',
            style: TextStyle(
            color: AppColor.secondPageTitleColor,
            fontSize: 30,
            
            fontWeight: FontWeight.w500,
           ),
           ),
           SizedBox(height: 50,),
           Container(
            padding: EdgeInsets.only(left: 5,
            right: 10
            ),
            width: 80,
            height: 30,
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20),
            
            ),
            color: AppColor.setsColor.withOpacity(0.3),
            ),
            child: Row(
              children: [
                Icon(Icons.timer,
                size: 20,
               

                ),
                Expanded(child: Container()),
                Text('60min'),


              ],
            ),
           )
           
          ],
         ),
            ):Container(
             padding: EdgeInsets.only(
              top: 20
             ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      top: 20,
                      right: 20,
                    ),
                    child: Row(
                      children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child:   Icon(Icons.arrow_back_ios),
                      ),
                        Spacer(),
                        Icon(Icons.info)
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),

                 playview(context),
                 controllview(context),

                 
                
                  
                  
                ],
              ),

            ),
             Container(
              margin: EdgeInsets.only(
                top: 300,
              ),
              padding: EdgeInsets.only(
                left: 20,
                top: 20,
                right: 30,
              ),
              width: MediaQuery.of(context).size.width,
              height: 510,
              decoration: BoxDecoration(
                color: AppColor.homePageBackground,
              
              ),

             child: Column(
              children: [
                Row(
                  children: [
                    Text('Circuit 1 ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,

                    ),
                    ),
                    Spacer(),
                    Icon(Icons.repeat_rounded,
                    color: AppColor.secondPageContainerGradient1stColor,
                    ),
                    Text('3 sets',
                    style: TextStyle(
                      color: AppColor.setsColor,
                    ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                  itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _ontapVideo(index);
                      debugPrint(index.toString());
                      setState(() {
                        if(playarea==false){
                          playarea=true;
                        }
                      });
                    },
                    child: Container(
                       padding: EdgeInsets.only(bottom: 20,),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      info[index]['thumbnail'],
                                      
                                      ),
                          
                                    fit: BoxFit.cover,
                                    ),
                                    
                                ),
                          
                              ),
                              Container(
                                height: 100,
                                width: 230,
                                
                                padding: EdgeInsets.only(
                                  left: 20,
                                  top: 20,
                          
                                ),
                                
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(info[index]['title'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,

                                    ),
                                    ),
                                    Text(info[index]['time'],
                                    style: TextStyle(
                                      color: AppColor.setsColor
                                    ),
                                    )
                          
                                  ],
                                ),
                          
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 10
                                ),
                                margin: EdgeInsets.only(
                                  top: 10,
                                ),
                                height: 20,
                                width: 90,
                               decoration: BoxDecoration(
                                 color: Colors.greenAccent.withOpacity(0.3),
                                 borderRadius: BorderRadius.circular(10,)
                               ),
                               child: Text(
                                '15s rest',
                                style: TextStyle(
                                  color: AppColor.setsColor,
                    
                                ),
                               ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 10,
                                    right: 10,
                                  ),
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 0.4,
                                    indent: 1,
                                    
                                  
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    
                    ),
                  );
                },
                itemCount: info.length,

                )
                
                )
              ],
             ),
            )
          ],
        )
      ),
    );
  }
}