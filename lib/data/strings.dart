import '../state/app_state.dart';

class S {
  static AppLanguage _lang = AppLanguage.fr;

  static void setLanguage(AppLanguage lang) => _lang = lang;

  static String get(String key) {
    final map = _lang == AppLanguage.ar ? _ar : _fr;
    return map[key] ?? _fr[key] ?? key;
  }

  static const _fr = <String, String>{
    // General
    'app_name': 'NeuroLink Kids',
    'tagline': 'Apprendre • Pratiquer • Grandir',
    'subtitle': 'Soutenir les enfants autistes',
    'hello': 'Bonjour, 👋',
    'search': 'Rechercher...',
    'save': 'Enregistrer',
    'cancel': 'Annuler',
    'continue_btn': 'Continuer',
    'back': 'Retour',
    'yes': 'Oui',
    'no': 'Non',

    // Language Selection
    'choose_language': 'Choisissez votre langue',
    'language_subtitle': 'Sélectionnez la langue de l\'application',

    // Welcome
    'sign_up': 'S\'inscrire',
    'log_in': 'Se connecter',

    // Login
    'welcome_back': 'Bienvenue',
    'login_subtitle': 'Connectez-vous pour continuer',
    'email': 'Email',
    'password': 'Mot de passe',
    'carte_nationale': 'Carte Nationale ID',
    'forgot_password': 'Mot de passe oublié ?',
    'no_account': 'Vous n\'avez pas de compte ?',

    // Signup
    'create_account': 'Créer un compte',
    'join_community': 'Rejoignez la communauté NeuroLink Kids',
    'parent_name': 'Nom du parent',
    'full_name': 'Nom complet',
    'confirm_password': 'Confirmer le mot de passe',
    'have_account': 'Vous avez déjà un compte ?',
    'choose_role': 'Choisissez votre rôle',
    'role_parent': 'Parent',
    'role_teacher': 'Enseignant',
    'role_doctor': 'Médecin',

    // Home tabs
    'tab_home': 'Accueil',
    'tab_activities': 'Activités',
    'tab_progress': 'Progrès',
    'tab_profile': 'Profil',
    'tab_students': 'Élèves',
    'tab_patients': 'Patients',
    'tab_reports': 'Rapports',

    // Parent Home
    'lets_learn': 'Apprenons quelque chose de nouveau aujourd\'hui !',
    'activities_tab': 'Activités',
    'reports_tab': 'Rapports',
    'videos_section': 'Vidéos',
    'activities_section': 'Activités',
    'see_all': 'Voir tout  →',
    'retake_assessment': 'Refaire l\'évaluation',
    'total_stars': 'Total des étoiles',
    'answer_questions': 'Répondre aux questions',

    // Teacher Home
    'teacher_greeting': 'Bonjour, 👋  Enseignant',
    'manage_students': 'Gérer les progrès de vos élèves',
    'class_overview': 'Vue d\'ensemble de la classe',
    'avg_task': 'Tâche moy.',
    'avg_score': 'Score moy.',
    'students_label': 'Élèves',
    'student_performance': 'Performance des élèves',
    'add_report': 'Ajouter un rapport',
    'recent_reports': 'Rapports récents',

    // Doctor Home
    'doctor_greeting': 'Bonjour, 👋  Médecin',
    'track_patients': 'Suivre les progrès et évaluations des patients',
    'patient_profile': 'Profil du patient',
    'age_label': 'Âge',
    'school_label': 'École',
    'diagnosis_label': 'Diagnostic',
    'add_medical_report': 'Ajouter un rapport médical',
    'medical_reports': 'Rapports médicaux',
    'recent_medical': 'Rapports médicaux récents',
    'no_medical_reports': 'Aucun rapport médical pour le moment',

    // Activities
    'all_activities': 'Toutes les activités',
    'activities_subtitle': 'Choisis une activité et apprends en t\'amusant',
    'colors_learning': 'Apprentissage des couleurs',
    'colors_subtitle': 'Reconnaître et associer les couleurs',
    'numbers_learning': 'Apprentissage des nombres',
    'numbers_subtitle': 'Apprendre à compter',
    'alphabet_learning': 'Apprentissage de l\'alphabet',
    'alphabet_subtitle': 'Lettres et sons',
    'animals_learning': 'Apprentissage des animaux',
    'animals_subtitle': 'Les animaux et leurs sons',
    'family_learning': 'Apprentissage de la famille',
    'family_subtitle': 'Membres de la famille et relations',
    'drawing_activity': 'Activité de dessin',
    'drawing_subtitle': 'Dessiner et créer',
    'memory_cards': 'Jeu de mémoire',
    'memory_subtitle': 'Associer les paires et entraîner la mémoire',
    'sorting_game': 'Jeu de tri',
    'sorting_subtitle': 'Trier et catégoriser',
    'emotions_title': 'Émotions',
    'emotions_subtitle': 'Sentiments',
    'routine_title': 'Routine',
    'routine_subtitle': 'Plans quotidiens',
    'relaxation_title': 'Relaxation',
    'relaxation_subtitle': 'Se calmer',
    'communication_title': 'Communication',
    'communication_subtitle': 'Pratiquer la parole',

    // Reports
    'no_reports': 'Aucun rapport pour le moment',
    'performance_label': 'Performance',
    'excellent': 'Excellent',
    'good': 'Bien',
    'average': 'Moyen',
    'poor': 'Faible',
    'behavior_label': 'Comportement',
    'strange_behavior': 'Comportement inhabituel',
    'emotion_label': 'Émotion',
    'notes_label': 'Notes',
    'learning_activities': 'Activités d\'apprentissage',
    'focused': 'Concentré',
    'distracted': 'Distrait',
    'social': 'Social',
    'isolated': 'Isolé',
    'hyperactive': 'Hyperactif',
    'calm': 'Calme',
    'reading': 'Lecture',
    'writing': 'Écriture',
    'math': 'Mathématiques',
    'drawing': 'Dessin',
    'group_activity': 'Activité de groupe',

    // Add Report
    'select_patient': 'Sélectionner le patient *',
    'medical_observation': 'Observation médicale',
    'medical_notes': 'Notes médicales',
    'diagnosis_update': 'Mise à jour du diagnostic',
    'recommendations': 'Recommandations',
    'save_medical_report': 'Enregistrer le rapport médical',

    // Progress
    'progress_title': 'Progrès',
    'tracking_progress': 'Suivi des progrès de',
    'activities_stat': 'Activités',
    'videos_stat': 'Vidéos',
    'reports_stat': 'Rapports',
    'score_stat': 'Score',
    'performance_by_cat': 'Performance par catégorie',
    'clinical_overview': 'Vue d\'ensemble clinique',
    'patients_stat': 'Patients',
    'medical_reports_stat': 'Rapports médicaux',
    'assessments_stat': 'Évaluations',
    'class_overview_title': 'Vue d\'ensemble de la classe',
    'students_stat': 'Élèves',
    'behavioral_trends': 'Tendances comportementales',

    // Profile
    'my_children': 'Mes enfants',
    'my_students': 'Mes élèves',
    'my_patients': 'Mes patients',
    'add_child': 'Ajouter un enfant',
    'preferences': 'Préférences',
    'logout': 'Se déconnecter',
    'activate': 'Activer',
    'boy': 'Garçon',
    'girl': 'Fille',
    'years_old': 'ans',

    // Add Child
    'add_child_title': 'Ajouter un enfant',
    'child_name': 'Nom de l\'enfant',
    'child_age': 'Âge',
    'gender': 'Genre',
    'school_name': 'Nom de l\'école',
    'diagnosis_type': 'Type de diagnostic',
    'started_school': 'Votre enfant a-t-il commencé l\'école ?',
    'continue_assessment': 'Continuer vers l\'évaluation',

    // Videos
    'video_social': 'Compétences sociales',
    'video_calm': 'Techniques de calme',
    'video_learn': 'Apprendre ensemble',
  };

  static const _ar = <String, String>{
    // General
    'app_name': 'نيورولينك كيدز',
    'tagline': 'تعلّم • تدرّب • انمو',
    'subtitle': 'دعم الأطفال المصابين بالتوحد',
    'hello': '👋 مرحباً،',
    'search': 'بحث...',
    'save': 'حفظ',
    'cancel': 'إلغاء',
    'continue_btn': 'متابعة',
    'back': 'رجوع',
    'yes': 'نعم',
    'no': 'لا',

    // Language Selection
    'choose_language': 'اختر لغتك',
    'language_subtitle': 'اختر لغة التطبيق',

    // Welcome
    'sign_up': 'إنشاء حساب',
    'log_in': 'تسجيل الدخول',

    // Login
    'welcome_back': 'مرحباً بعودتك',
    'login_subtitle': 'سجّل دخولك للمتابعة',
    'email': 'البريد الإلكتروني',
    'password': 'كلمة المرور',
    'carte_nationale': 'رقم البطاقة الوطنية',
    'forgot_password': 'نسيت كلمة المرور؟',
    'no_account': 'ليس لديك حساب؟',

    // Signup
    'create_account': 'إنشاء حساب',
    'join_community': 'انضم إلى مجتمع نيورولينك كيدز',
    'parent_name': 'اسم الوالد',
    'full_name': 'الاسم الكامل',
    'confirm_password': 'تأكيد كلمة المرور',
    'have_account': 'لديك حساب بالفعل؟',
    'choose_role': 'اختر دورك',
    'role_parent': 'والد',
    'role_teacher': 'معلم',
    'role_doctor': 'طبيب',

    // Home tabs
    'tab_home': 'الرئيسية',
    'tab_activities': 'الأنشطة',
    'tab_progress': 'التقدم',
    'tab_profile': 'الملف الشخصي',
    'tab_students': 'التلاميذ',
    'tab_patients': 'المرضى',
    'tab_reports': 'التقارير',

    // Parent Home
    'lets_learn': 'هيا نتعلم شيئاً جديداً اليوم!',
    'activities_tab': 'الأنشطة',
    'reports_tab': 'التقارير',
    'videos_section': 'فيديوهات',
    'activities_section': 'الأنشطة',
    'see_all': '← عرض الكل',
    'retake_assessment': 'إعادة التقييم',
    'total_stars': 'مجموع النجوم',
    'answer_questions': 'أجب على الأسئلة',

    // Teacher Home
    'teacher_greeting': '👋 مرحباً، المعلم',
    'manage_students': 'إدارة تقدم تلاميذك',
    'class_overview': 'نظرة عامة على الفصل',
    'avg_task': 'مهام مت.',
    'avg_score': 'درجة مت.',
    'students_label': 'التلاميذ',
    'student_performance': 'أداء التلاميذ',
    'add_report': 'إضافة تقرير',
    'recent_reports': 'التقارير الأخيرة',

    // Doctor Home
    'doctor_greeting': '👋 مرحباً، الطبيب',
    'track_patients': 'تتبع تقدم المرضى والتقييمات',
    'patient_profile': 'ملف المريض',
    'age_label': 'العمر',
    'school_label': 'المدرسة',
    'diagnosis_label': 'التشخيص',
    'add_medical_report': 'إضافة تقرير طبي',
    'medical_reports': 'التقارير الطبية',
    'recent_medical': 'التقارير الطبية الأخيرة',
    'no_medical_reports': 'لا توجد تقارير طبية حتى الآن',

    // Activities
    'all_activities': 'جميع الأنشطة',
    'activities_subtitle': 'اختر نشاطاً وتعلم بالمرح',
    'colors_learning': 'تعلم الألوان',
    'colors_subtitle': 'التعرف على الألوان ومطابقتها',
    'numbers_learning': 'تعلم الأرقام',
    'numbers_subtitle': 'تعلم العد والأرقام',
    'alphabet_learning': 'تعلم الحروف',
    'alphabet_subtitle': 'الحروف والأصوات',
    'animals_learning': 'تعلم الحيوانات',
    'animals_subtitle': 'الحيوانات وأصواتها',
    'family_learning': 'تعلم العائلة',
    'family_subtitle': 'أفراد العائلة والعلاقات',
    'drawing_activity': 'نشاط الرسم',
    'drawing_subtitle': 'الرسم والإبداع',
    'memory_cards': 'لعبة الذاكرة',
    'memory_subtitle': 'مطابقة الأزواج وتدريب الذاكرة',
    'sorting_game': 'لعبة الفرز',
    'sorting_subtitle': 'الفرز والتصنيف',
    'emotions_title': 'المشاعر',
    'emotions_subtitle': 'الأحاسيس',
    'routine_title': 'الروتين',
    'routine_subtitle': 'الخطط اليومية',
    'relaxation_title': 'الاسترخاء',
    'relaxation_subtitle': 'الهدوء',
    'communication_title': 'التواصل',
    'communication_subtitle': 'ممارسة الكلام',

    // Reports
    'no_reports': 'لا توجد تقارير حتى الآن',
    'performance_label': 'الأداء',
    'excellent': 'ممتاز',
    'good': 'جيد',
    'average': 'متوسط',
    'poor': 'ضعيف',
    'behavior_label': 'السلوك',
    'strange_behavior': 'سلوك غير عادي',
    'emotion_label': 'المشاعر',
    'notes_label': 'ملاحظات',
    'learning_activities': 'أنشطة التعلم',
    'focused': 'مركّز',
    'distracted': 'مشتت',
    'social': 'اجتماعي',
    'isolated': 'منعزل',
    'hyperactive': 'مفرط النشاط',
    'calm': 'هادئ',
    'reading': 'قراءة',
    'writing': 'كتابة',
    'math': 'رياضيات',
    'drawing': 'رسم',
    'group_activity': 'نشاط جماعي',

    // Add Report
    'select_patient': 'اختر المريض *',
    'medical_observation': 'الملاحظة الطبية',
    'medical_notes': 'ملاحظات طبية',
    'diagnosis_update': 'تحديث التشخيص',
    'recommendations': 'التوصيات',
    'save_medical_report': 'حفظ التقرير الطبي',

    // Progress
    'progress_title': 'التقدم',
    'tracking_progress': 'تتبع تقدم',
    'activities_stat': 'الأنشطة',
    'videos_stat': 'فيديوهات',
    'reports_stat': 'التقارير',
    'score_stat': 'النتيجة',
    'performance_by_cat': 'الأداء حسب الفئة',
    'clinical_overview': 'نظرة سريرية عامة',
    'patients_stat': 'المرضى',
    'medical_reports_stat': 'التقارير الطبية',
    'assessments_stat': 'التقييمات',
    'class_overview_title': 'نظرة عامة على الفصل',
    'students_stat': 'التلاميذ',
    'behavioral_trends': 'الاتجاهات السلوكية',

    // Profile
    'my_children': 'أطفالي',
    'my_students': 'تلاميذي',
    'my_patients': 'مرضاي',
    'add_child': 'إضافة طفل',
    'preferences': 'التفضيلات',
    'logout': 'تسجيل الخروج',
    'activate': 'تفعيل',
    'boy': 'ولد',
    'girl': 'بنت',
    'years_old': 'سنوات',

    // Add Child
    'add_child_title': 'إضافة طفل',
    'child_name': 'اسم الطفل',
    'child_age': 'العمر',
    'gender': 'الجنس',
    'school_name': 'اسم المدرسة',
    'diagnosis_type': 'نوع التشخيص',
    'started_school': 'هل بدأ طفلك المدرسة؟',
    'continue_assessment': 'المتابعة إلى التقييم',

    // Videos
    'video_social': 'مهارات اجتماعية',
    'video_calm': 'تقنيات الهدوء',
    'video_learn': 'تعلم معاً',
  };
}
