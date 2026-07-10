/// All UI-facing strings for the portfolio.
///
/// Only contains copy that appears in widgets — labels, button text,
/// error messages, empty states. Personal data lives in `lib/data/profile.dart`.
///
/// When internationalisation (i18n) is needed, this class becomes
/// the single migration target.
abstract class AppStrings {
  AppStrings._();

  // ---------------------------------------------------------------------------
  // Hero CTAs
  // ---------------------------------------------------------------------------
  static const String viewProjects   = 'View Projects';
  static const String heroResume     = 'Resume';
  static const String downloadResume = 'Download Resume';
  static const String viewResume     = 'View Resume';
  static const String contactMe      = 'Contact Me';
  static const String hireMe         = 'Hire Me';

  // ---------------------------------------------------------------------------
  // Navigation labels
  // ---------------------------------------------------------------------------
  static const String navHome         = 'Home';
  static const String navProjects     = 'Projects';
  static const String navExperience   = 'Experience';
  static const String navCertificates = 'Certificates';
  static const String navResume       = 'Resume';
  static const String navContact      = 'Contact';

  // ---------------------------------------------------------------------------
  // Section titles (displayed in SectionHeader)
  // ---------------------------------------------------------------------------
  static const String sectionQuickSnapshot    = 'Quick Snapshot';
  static const String sectionCurrentFocus     = 'Current Focus';
  static const String sectionSkills           = 'Skills';
  static const String sectionExperience       = 'Professional Experience';
  static const String sectionFeaturedProject  = 'Featured Project';
  static const String sectionOtherProjects    = 'Other Projects';
  static const String sectionEducation        = 'Education';
  static const String sectionCertifications   = 'Certifications';
  static const String sectionResume           = 'Resume';
  static const String sectionContact          = 'Get In Touch';

  // ---------------------------------------------------------------------------
  // Status / availability labels
  // ---------------------------------------------------------------------------
  static const String openToWork      = 'Open To Work';
  static const String openToRemote    = 'Open To Remote';
  static const String currentRole     = 'Current Role';
  static const String present         = 'Present';
  static const String featured        = 'Featured';
  static const String finalYearProject = 'Final Year Project';

  // ---------------------------------------------------------------------------
  // Project / experience labels
  // ---------------------------------------------------------------------------
  static const String viewOnGitHub      = 'View on GitHub';
  static const String viewLive          = 'View Live';
  static const String technologies      = 'Technologies';
  static const String responsibilities  = 'Responsibilities';
  static const String projects          = 'Projects';
  static const String productionApps    = 'Production Apps';
  static const String techStack         = 'Tech Stack';
  static const String caseStudy         = 'Case Study';
  static const String portfolioProject  = 'Portfolio project';
  static const String sendAMessage      = 'Send a Message';
  static const String verified          = 'Verified';
  static const String credentialOnFile  = 'Credential on file';

  // ---------------------------------------------------------------------------
  // Contact form
  // ---------------------------------------------------------------------------
  static const String yourName      = 'Your Name';
  static const String yourEmail     = 'Your Email';
  static const String subject       = 'Subject';
  static const String yourMessage   = 'Your Message';
  static const String sendMessage   = 'Send Message';
  static const String orReachVia    = 'Or reach me directly via';

  // ---------------------------------------------------------------------------
  // Form validation messages
  // ---------------------------------------------------------------------------
  static const String validationNameRequired    = 'Name is required';
  static const String validationEmailRequired   = 'Email is required';
  static const String validationEmailInvalid    = 'Enter a valid email address';
  static const String validationMessageRequired = 'Message is required';
  static const String validationMessageShort    = 'Message must be at least 20 characters';

  // ---------------------------------------------------------------------------
  // Empty / error states
  // ---------------------------------------------------------------------------
  static const String errorGeneral        = 'Something went wrong';
  static const String errorRetry          = 'Retry';
  static const String emptyProjects       = 'No projects to show yet';
  static const String emptyCertificates   = 'No certifications to show yet';

  // ---------------------------------------------------------------------------
  // Resume section
  // ---------------------------------------------------------------------------
  static const String resumeDescription =
      'View or download the full resume as a PDF.';
  static const String openInBrowser = 'Open in Browser';

  // ---------------------------------------------------------------------------
  // Education labels
  // ---------------------------------------------------------------------------
  static const String cgpa       = 'CGPA';
  static const String degree     = 'Degree';
  static const String university = 'University';

  // ---------------------------------------------------------------------------
  // Theme toggle tooltip
  // ---------------------------------------------------------------------------
  static const String switchToDark  = 'Switch to dark mode';
  static const String switchToLight = 'Switch to light mode';
  static const String switchToSystem = 'Use system theme';
}
