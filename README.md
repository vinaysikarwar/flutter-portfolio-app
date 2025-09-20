# My Portfolio App

A beautiful and responsive Flutter portfolio app that showcases your resume, projects, and personal information.

## Features

- **Responsive Design**: Works perfectly on mobile, tablet, and desktop
- **Dark/Light Theme**: Toggle between light and dark themes
- **Smooth Animations**: Beautiful animations and transitions throughout the app
- **Professional Layout**: Clean and modern design
- **Multiple Sections**:
  - Home/About: Personal introduction with animated titles
  - Resume: Professional experience, education, skills, and achievements
  - Portfolio: Project gallery with descriptions and links
  - Contact: Contact information, social media links, and contact form

## Screenshots

*(Add your app screenshots here)*

## Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK
- An IDE (VS Code, Android Studio, etc.)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/my_portfolio_app.git
   cd my_portfolio_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Customization

### Personal Information

Edit the `lib/constants/app_constants.dart` file to update your personal information:

```dart
class AppConstants {
  static const String name = 'Your Name';
  static const String title = 'Flutter Developer';
  static const String email = 'your.email@example.com';
  static const String phone = '+1 (555) 123-4567';
  static const String location = 'Your City, Country';
  // ... more constants
}
```

### Profile Picture

Add your profile picture to the `assets/images/` folder and update the `ProfileAvatar` widget to use your image:

```dart
const ProfileAvatar(
  size: 200,
  imageUrl: 'assets/images/your_profile_picture.jpg',
)
```

### Projects

Update the projects list in `lib/screens/portfolio_screen.dart` with your own projects:

```dart
final projects = [
  {
    'title': 'Your Project Name',
    'description': 'Project description...',
    'technologies': ['Flutter', 'Firebase', 'etc'],
    'github': 'https://github.com/yourusername/project',
    // ... more project details
  },
  // Add more projects
];
```

### Experience and Education

Update your work experience and education in the `app_constants.dart` file or directly in the `resume_screen.dart` file.

### Social Media Links

Update your social media URLs in the `app_constants.dart` file:

```dart
static const String linkedinUrl = 'https://linkedin.com/in/yourprofile';
static const String githubUrl = 'https://github.com/yourusername';
// ... more social links
```

## Dependencies

- `animate_do`: For smooth animations
- `animated_text_kit`: For animated text effects
- `font_awesome_flutter`: For beautiful icons
- `google_fonts`: For custom fonts
- `url_launcher`: For opening external links
- `responsive_framework`: For responsive design

## Building for Release

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

Your Name - [your.email@example.com](mailto:your.email@example.com)

Project Link: [https://github.com/yourusername/my_portfolio_app](https://github.com/yourusername/my_portfolio_app)

## Acknowledgments

- Flutter team for the amazing framework
- All the package authors whose work made this project possible
- Icons provided by Font Awesome
- Fonts provided by Google Fonts
