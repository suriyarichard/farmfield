import 'package:farmfield/pallets/color.dart';
import 'package:farmfield/widgets/crop/timeline.dart';
import 'package:farmfield/widgets/dashboard/moister.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  // const InfoScreen({super.key});
  final String id;

  const InfoScreen({
    super.key,
    required this.id,
  });
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'InfoScreen',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: AppColor.titleColor),
              ),
              subtitle: Text(
                'Let’s help you',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColor.titleColor),
              ),
            ),
          ],
        ),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 200.0,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: const Image(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2022/04/06/12/49/countryside-7115530_1280.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                // const SenorCard(),
                // Text(id)
                 Timeline(id: widget.id),

                // FutureBuilder(
                //   future: complaintService.get(context),
                //   builder:
                //       (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       // Display a loading spinner while waiting for data
                //       return Center(child: CircularProgressIndicator());
                //     } else if (snapshot.hasError) {
                //       // Display an error message if the future throws an error
                //       return Text("Error: ${snapshot.error}");
                //     } else {
                //       // Call the function from the instance of MyClass and display the fetched data
                //       complaints = snapshot.data;
                //       if (complaints.length == 0) {
                //         return NoData(text: 'No InfoScreen Available');
                //       } else {
                //         return SizedBox(
                //           height: MediaQuery.of(context).size.height * 0.75,
                //           width: 325,
                //           child: ListView.builder(
                //             itemCount: snapshot.data.length,
                //             itemBuilder: (BuildContext context, int index) {
                //               return ComplaintCard(
                //                 onTap: () {},
                //                 createdDateAndTime: snapshot.data[index]
                //                     ['createdAt'] as Timestamp,
                //                 statusMessage: snapshot.data[index]['status'],
                //                 complaintTitle: snapshot.data[index]
                //                     ['description'],
                //               );
                //             },
                //           ),
                //         );
                //       }
                //     }
                //   },
                // ),
              ]),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class InfoScreen extends StatelessWidget {
//   const InfoScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//         body: Center(
//       child: Text("suriya prakash"),
//     ));
//   }
// }
