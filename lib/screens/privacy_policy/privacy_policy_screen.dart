import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/icons/Group 9108.svg",
              height: 25,
              width: 25,
            )),
        title: const Text(
          "Privacy Policy",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              "Lorem ipsum dolor",
              style: policyTitleStyle,
            ),
            Text('''

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec fringilla imperdiet vehicula. Quisque at ligula urna. Curabitur convallis nulla lacus. Mauris vitae feugiat velit, non eleifend augue. Nullam sed vestibulum arcu. Quisque euismod quis neque ut laoreet. Nulla pulvinar, elit in aliquam porttitor, purus est interdum magna, at rutrum lectus lectus ac metus. In rutrum blandit imperdiet. Morbi eget iaculis enim, eget semper sapien. Phasellus gravida sodales sapien eget lacinia. Pellentesque lorem elit, accumsan maximus condimentum eu, facilisis eget libero. Pellentesque condimentum eleifend nisi vel condimentum. Praesent lobortis erat eget imperdiet mollis. Vivamus felis magna, elementum et condimentum sit amet, porta a enim. Nulla facilisi. Ut sit amet pharetra quam.'''),
            Text(
              "Consent",
              style: policyTitleStyle,
            ),
            Text('''

By using our website, you hereby consent to our Privacy Policy and agree to its terms.
'''),
            Text(
              "Information we collect",
              style: policyTitleStyle,
            ),
            Text('''

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec fringilla imperdiet vehicula. Quisque at ligula urna. Curabitur convallis nulla lacus. Mauris vitae feugiat velit, non eleifend augue. Nullam sed vestibulum arcu. Quisque euismod quis neque ut laoreet. Nulla pulvinar, elit in aliquam porttitor, purus est interdum magna, at rutrum lectus lectus ac metus. In rutrum blandit imperdiet. Morbi eget iaculis enim, eget semper sapien. Phasellus gravida sodales sapien eget lacinia. Pellentesque lorem elit, accumsan maximus condimentum eu, facilisis eget libero. Pellentesque condimentum eleifend nisi vel condimentum. Praesent lobortis erat eget imperdiet mollis. Vivamus felis magna, elementum et condimentum sit amet, porta a enim. Nulla facilisi. Ut sit amet pharetra quam.'''),
            Text(
              "How we use your information",
              style: policyTitleStyle,
            ),
            Text('''

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec fringilla imperdiet vehicula. Quisque at ligula urna. Curabitur convallis nulla lacus. Mauris vitae feugiat velit, non eleifend augue. Nullam sed vestibulum arcu. Quisque euismod quis neque ut laoreet. Nulla pulvinar, elit in aliquam porttitor, purus est interdum magna, at rutrum lectus lectus ac metus. In rutrum blandit imperdiet. Morbi eget iaculis enim, eget semper sapien. Phasellus gravida sodales sapien eget lacinia. Pellentesque lorem elit, accumsan maximus condimentum eu, facilisis eget libero. Pellentesque condimentum eleifend nisi vel condimentum. Praesent lobortis erat eget imperdiet mollis. Vivamus felis magna, elementum et condimentum sit amet, porta a enim. Nulla facilisi. Ut sit amet pharetra quam.
'''),
            Text(
              "Log Files",
              style: policyTitleStyle,
            ),
            Text('''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec fringilla imperdiet vehicula. Quisque at ligula urna. Curabitur convallis nulla lacus. Mauris vitae feugiat velit, non eleifend augue. Nullam sed vestibulum arcu. Quisque euismod quis neque ut laoreet. Nulla pulvinar, elit in aliquam porttitor, purus est interdum magna, at rutrum lectus lectus ac metus. In rutrum blandit imperdiet. Morbi eget iaculis enim, eget semper sapien. Phasellus gravida sodales sapien eget lacinia. Pellentesque lorem elit, accumsan maximus condimentum eu, facilisis eget libero. Pellentesque condimentum eleifend nisi vel condimentum. Praesent lobortis erat eget imperdiet mollis. Vivamus felis magna, elementum et condimentum sit amet, porta a enim. Nulla facilisi. Ut sit amet pharetra quam.'''),
            Text(
              "Advertising Partners Privacy Policies",
              style: policyTitleStyle,
            ),
            Text('''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec fringilla imperdiet vehicula. Quisque at ligula urna. Curabitur convallis nulla lacus. Mauris vitae feugiat velit, non eleifend augue. Nullam sed vestibulum arcu. Quisque euismod quis neque ut laoreet. Nulla pulvinar, elit in aliquam porttitor, purus est interdum magna, at rutrum lectus lectus ac metus. In rutrum blandit imperdiet. Morbi eget iaculis enim, eget semper sapien. Phasellus gravida sodales sapien eget lacinia. Pellentesque lorem elit, accumsan maximus condimentum eu, facilisis eget libero. Pellentesque condimentum eleifend nisi vel condimentum. Praesent lobortis erat eget imperdiet mollis. Vivamus felis magna, elementum et condimentum sit amet, porta a enim. Nulla facilisi. Ut sit amet pharetra quam.'''),
            Text(
              "Third Party Privacy Policies",
              style: policyTitleStyle,
            ),
            Text('''

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec fringilla imperdiet vehicula. Quisque at ligula urna. Curabitur convallis nulla lacus. Mauris vitae feugiat velit, non eleifend augue. Nullam sed vestibulum arcu. Quisque euismod quis neque ut laoreet. Nulla pulvinar, elit in aliquam porttitor, purus est interdum magna, at rutrum lectus lectus ac metus. In rutrum blandit imperdiet. Morbi eget iaculis enim, eget semper sapien. Phasellus gravida sodales sapien eget lacinia. Pellentesque lorem elit, accumsan maximus condimentum eu, facilisis eget libero. Pellentesque condimentum eleifend nisi vel condimentum. Praesent lobortis erat eget imperdiet mollis. Vivamus felis magna, elementum et condimentum sit amet, porta a enim. Nulla facilisi. Ut sit amet pharetra quam.'''),
            Text(
              "CCPA Privacy Rights (Do Not Sell My Personal Information)",
              style: policyTitleStyle,
            ),
            Text('''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec fringilla imperdiet vehicula. Quisque at ligula urna. Curabitur convallis nulla lacus. Mauris vitae feugiat velit, non eleifend augue. Nullam sed vestibulum arcu. Quisque euismod quis neque ut laoreet. Nulla pulvinar, elit in aliquam porttitor, purus est interdum magna, at rutrum lectus lectus ac metus. In rutrum blandit imperdiet. Morbi eget iaculis enim, eget semper sapien. Phasellus gravida sodales sapien eget lacinia. Pellentesque lorem elit, accumsan maximus condimentum eu, facilisis eget libero. Pellentesque condimentum eleifend nisi vel condimentum. Praesent lobortis erat eget imperdiet mollis. Vivamus felis magna, elementum et condimentum sit amet, porta a enim. Nulla facilisi. Ut sit amet pharetra quam.'''),
            Text(
              "GDPR Data Protection Rights",
              style: policyTitleStyle,
            ),
            Text('''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec fringilla imperdiet vehicula. Quisque at ligula urna. Curabitur convallis nulla lacus. Mauris vitae feugiat velit, non eleifend augue. Nullam sed vestibulum arcu. Quisque euismod quis neque ut laoreet. Nulla pulvinar, elit in aliquam porttitor, purus est interdum magna, at rutrum lectus lectus ac metus. In rutrum blandit imperdiet. Morbi eget iaculis enim, eget semper sapien. Phasellus gravida sodales sapien eget lacinia. Pellentesque lorem elit, accumsan maximus condimentum eu, facilisis eget libero. Pellentesque condimentum eleifend nisi vel condimentum. Praesent lobortis erat eget imperdiet mollis. Vivamus felis magna, elementum et condimentum sit amet, porta a enim. Nulla facilisi. Ut sit amet pharetra quam.'''),
            Text(
              "Children's Information",
              style: policyTitleStyle,
            ),
            Text('''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec fringilla imperdiet vehicula. Quisque at ligula urna. Curabitur convallis nulla lacus. Mauris vitae feugiat velit, non eleifend augue. Nullam sed vestibulum arcu. Quisque euismod quis neque ut laoreet. Nulla pulvinar, elit in aliquam porttitor, purus est interdum magna, at rutrum lectus lectus ac metus. In rutrum blandit imperdiet. Morbi eget iaculis enim, eget semper sapien. Phasellus gravida sodales sapien eget lacinia. Pellentesque lorem elit, accumsan maximus condimentum eu, facilisis eget libero. Pellentesque condimentum eleifend nisi vel condimentum. Praesent lobortis erat eget imperdiet mollis. Vivamus felis magna, elementum et condimentum sit amet, porta a enim. Nulla facilisi. Ut sit amet pharetra quam.''')
          ],
        ),
      ),
    );
  }
}
