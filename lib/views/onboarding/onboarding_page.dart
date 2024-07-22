import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset('assets/netflix_logo.svg'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              launchUrlString('https://help.netflix.com/pt/node/100628');
            },
            child: const Text(
              "Política de Privacidade",
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background with images
          const Positioned.fill(
            child: RowImages(),
          ),
          // Foreground content
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    "Todos os seus filmes e séries em um só lugar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Assista onde quiser, quando quiser.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/login");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 18),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        "ENTRE OU INSCREVA-SE",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RowImages extends StatelessWidget {
  const RowImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: List.generate(4, (index) {
              return Expanded(
                child: Image.asset('assets/image_${index + 1}.png'),
              );
            }),
          ),
        ),
        Expanded(
          child: Column(
            children: List.generate(5, (index) {
              return Expanded(
                child: Image.asset('assets/image_${index + 5}.png'),
              );
            }),
          ),
        ),
        Expanded(
          child: Column(
            children: List.generate(4, (index) {
              return Expanded(
                child: Image.asset('assets/image_${index + 10}.png'),
              );
            }),
          ),
        ),
      ],
    );
  }
}
