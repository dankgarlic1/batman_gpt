# Batman GPT

Batman GPT is a Flutter project that utilizes the GPT-3.5 language model to create an interactive chatbot application with a Batman theme.

## Features

- Interactive chat interface with Batman-themed design
- Uses the OpenAI GPT-3.5 language model for generating responses
- Supports sending and receiving messages between the user and the chatbot
- Messages are displayed in a conversation-style format
- The chat history is stored in a list and can be scrolled vertically
- User messages are displayed on the right side with a Batman avatar
- Bot messages are displayed on the left side with an Alfred avatar
- Long-pressing on a message copies the message text to the clipboard
- The user can send messages by typing in the text input field or tapping the Batwing icon


## Dependencies

The project relies on the following Flutter packages:

- `cupertino_icons: ^1.0.2`: Provides the Cupertino icons font for iOS-style icons.
- `chat_gpt_sdk: ^2.2.2`: Implements the OpenAI GPT-3.5 language model.
- `http: ^1.0.0`: Allows making HTTP requests to the OpenAI API.
- `animated_text_kit: ^4.2.2`: Provides animated text effects.
- `flutter_spinkit: ^5.2.0`: Offers various loading spinners for visual effects.

## Installation

1. Clone the project repository:

   ```
   git clone https://github.com/your-username/bataman_gpt.git
   ```

2. Change to the project directory:

   ```
   cd bataman_gpt
   ```

3. Fetch the dependencies using Flutter:

   ```
   flutter pub get
   ```

4. Run the application:

   ```
   flutter run
   ```

## Usage

1. Launch the application on an emulator or physical device.

2. Enter your messages in the text input field at the bottom of the screen.

3. Press Enter or tap the Batwing icon to send your message.

4. The chatbot will generate a response based on the entered message and display it in the chat area.

5. Long-press on a message to copy its text to the clipboard.

## Configuration

To configure the project, you can modify the `pubspec.yaml` file. Here are some key sections and their purposes:

- `dependencies`: Specifies the Flutter and package dependencies for the project.
- `assets`: Lists the image assets used in the application.
- `main.dart`: Contains the main entry point of the application and sets up the Flutter app's theme and initial screen.
- `chat_message.dart`: Defines the `chat_message` class, which represents a single message in the chat interface.
- `chat_screen_layout.dart`: Implements the chat screen layout and handles user interactions and message handling.

## Versioning

The version number and build number for the application are specified in the `pubspec.yaml` file. You can adjust them by changing the values of `version` and `build-number`. For more information about versioning in Flutter, refer to the [official documentation](https://flutter.dev/docs/development/ui/assets-and-images).

## License

This project is licensed under the [MIT License](LICENSE).

---

Enjoy chatting with Batman and Alfred using the Bataman GPT application! If you have any questions or need further assistance, feel free to reach out.