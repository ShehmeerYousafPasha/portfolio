import 'models/certificate_model.dart';

/// Professional certifications earned by Shehmeer Yousaf.
///
/// When migrating to Supabase, replace with a repository fetch.
const List<CertificateModel> certificatesData = [
  CertificateModel(
    id: 'scrum-fundamentals',
    title: 'Scrum Fundamentals Certified',
    issuer: 'SCRUMstudy',
    skills: ['Scrum', 'Agile', 'Project Management'],
  ),
  CertificateModel(
    id: 'ibm-frontend',
    title: 'Front-End Development',
    issuer: 'IBM',
    skills: ['HTML', 'CSS', 'JavaScript', 'React'],
  ),
  CertificateModel(
    id: 'ibm-cybersecurity',
    title: 'Cybersecurity Fundamentals',
    issuer: 'IBM',
    skills: ['Cybersecurity', 'Network Security', 'Security Fundamentals'],
  ),
];
