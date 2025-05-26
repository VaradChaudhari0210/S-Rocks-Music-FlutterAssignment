import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/service_card.dart';
import '../Views/service_detail_screen.dart';
import '../providers/service_provider.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // Accessing the provider
    final servicesAsyncValue = ref.watch(servicesProvider);

    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Image(image: AssetImage("assets/images/BottomNav_Home.png")), label: 'Home'),
            BottomNavigationBarItem(icon: Image(image: AssetImage("assets/images/BottomNav_News.png")), label: 'News'),
            BottomNavigationBarItem(icon: Image(image: AssetImage("assets/images/BottomNav_TrackBox.png")), label: 'TrackBox'),
            BottomNavigationBarItem(icon: Image(image: AssetImage("assets/images/BottomNav_Projects.png")), label: 'Projects'),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 16,
                ),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFA90140),
                      Color(0xFF550120),
                    ]
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                              left:16,
                            )
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search "Punjabi Lyrics"',
                              hintStyle: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Syne',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),
                              filled: true,
                              fillColor: Colors.grey[800],
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: Icon(Icons.mic),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        PopupMenuButton<String>(
                          icon: Icon(Icons.account_circle,size: 40,color: Color(0xFFEADDFF),),
                          itemBuilder: (context) => [
                            PopupMenuItem(value: 'Logout', child: Text('Logout')),
                          ],
                          onSelected: (value) {
                            if (value == 'Logout') {
                              print("Logout selected");
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0), // Adjust padding as needed
                          child: Align(
                            alignment: Alignment.center, // Or Alignment.centerLeft, etc. to position the text block
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center, // Or CrossAxisAlignment.start
                              children: [
                                Text(
                                    'Claim your',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Syne',
                                      fontWeight: FontWeight.w700,
                                    )
                                ),
                                Text(
                                  'Free Demo',
                                  style: TextStyle(
                                      fontSize: 45,
                                      color: Colors.white,
                                      fontFamily: 'Lobster'
                                  ),
                                ),
                                Text(
                                  'for custom Music Production',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Syne',
                                  ),
                                ),
                                SizedBox(height: 10,),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                  ),
                                  child: Text(
                                      'Book Now',
                                      style: TextStyle(
                                        fontFamily: 'Syne',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      )
                                  ),
                                ),
                                SizedBox(height:45),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left:-30,
                          child: Image(
                            image: AssetImage("assets/images/Layer_1Disk.png"),
                            errorBuilder: (context, error, stackTrace) {
                              print("Error loading image: lib/assets/Layer_1Disk.png. Error: $error");
                              return SizedBox(width: 70, height: 70, child: Icon(Icons.error)); // Placeholder
                            },
                          ),
                        ),
                        Positioned(
                          top: 80,
                          right: -42,
                          child: Image(
                            image: AssetImage("assets/images/Layer_1Piano.png"),
                            errorBuilder: (context, error, stackTrace) {
                              print("Error loading image: lib/assets/Layer_1Piano.png. Error: $error");
                              return SizedBox(width: 70, height: 70, child: Icon(Icons.error)); // Placeholder
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                    'Hire hand-picked Pros for popular music services',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Syne'
                    )
                ),
              ),
              SizedBox(height: 10),

              // Using servicesAsyncValue.when to handle loading, error, and data states
              servicesAsyncValue.when(
                data: (services) {
                  if (services.isEmpty) {
                    return Center(
                        child: Text(
                            'No services available.',
                            style: TextStyle(color: Colors.white70)
                        )
                    );
                  }
                  return Column(
                    children: services.map((service) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ServiceDetailScreen(
                                  serviceTitle: service.title),
                        ),
                      ),
                      child: ServiceCard(service: service),
                    ))
                        .toList(),
                  );
                },
                loading: () => Center(child: CircularProgressIndicator(color: Colors.white)),
                error: (error, stackTrace) => Center(
                    child: Text(
                        'Error: ${error.toString()}',
                        style: TextStyle(color: Colors.red)
                    )
                ),
              ),
            ],
          ),
        )
    );
  }
}
