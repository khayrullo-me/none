Map<String, String> errorMessages = {
  // Common errors
  'invalid-email': 'Kiritilgan email manzili noto‘g‘ri.',
  'user-disabled': 'Bu hisob o‘chirilgan.',
  'user-not-found': 'Bu emailga mos foydalanuvchi topilmadi.',
  'wrong-password': 'Parol noto‘g‘ri.',
  'email-already-in-use': 'Bu email allaqachon ro‘yxatdan o‘tgan.',
  'weak-password': 'Parol juda oddiy. Iltimos, kuchliroq parol tanlang.',

  // Signup-related errors
  'operation-not-allowed': 'Email orqali ro‘yxatdan o‘tish hozirda yoqilmagan.',
  'invalid-credential': 'Kiritilgan ma’lumotlar noto‘g‘ri.',

  // Verification and authentication
  'requires-recent-login': 'Ushbu amalni bajarish uchun qayta tizimga kirishingiz kerak.',
  'invalid-verification-code': 'SMS orqali kiritilgan tasdiqlash kodi noto‘g‘ri.',
  'invalid-verification-id': 'Tasdiqlash identifikatori noto‘g‘ri.',

  // Network-related errors
  'network-request-failed': 'Tarmoq bilan bog‘liq xato. Iltimos, internetni tekshiring.',
  'timeout': 'So‘rov vaqt o‘tib ketgani sababli bajarilmadi. Iltimos, qayta urinib ko‘ring.',
  'quota-exceeded': 'So‘rov limiti oshib ketdi. Keyinroq qayta urinib ko‘ring.',

  // Provider-related errors
  'provider-already-linked': 'Bu autentifikatsiya provayderi hisobingizga bog‘langan.',
  'credential-already-in-use': 'Bu autentifikatsiya ma’lumotlari boshqa hisobga bog‘langan.',
  'account-exists-with-different-credential': 'Bu email boshqa autentifikatsiya usuli orqali bog‘langan.',

  // Token-related errors
  'invalid-action-code': 'Ushbu havola yoki amal muddati o‘tgan.',
  'expired-action-code': 'Tasdiqlash kodi muddati o‘tib ketgan.',
  'invalid-custom-token': 'Token noto‘g‘ri. Iltimos, administratorga murojaat qiling.',
  'custom-token-mismatch': 'Token mos emas. Iltimos, qayta urinib ko‘ring.',

  // Multi-factor authentication
  'mfa-required': 'Ko‘p faktorli autentifikatsiya talab qilinmoqda.',
  'mfa-enrollment-not-found': 'Ko‘p faktorli autentifikatsiya mos yozuvi topilmadi.',

  // Email and password recovery
  'missing-email': 'Email manzilini kiriting.',
  'missing-password': 'Parolni kiriting.',
  'too-many-requests': 'Ko‘p marta urinish. Iltimos, birozdan keyin qayta urinib ko‘ring.',

  // Server errors
  'internal-error': 'Serverda xato yuz berdi. Keyinroq qayta urinib ko‘ring.',
  'undefined-error': 'Aniqlanmagan xato yuz berdi.',

  // Other potential errors
  'app-not-authorized': 'Ilova Firebase loyihasiga ruxsat etilmagan.',
  'user-token-expired': 'Foydalanuvchi tokenining muddati tugagan. Iltimos, qayta tizimga kiring.',
  'user-mismatch': 'Foydalanuvchi hisoblari mos kelmadi.',
  'app-deleted': 'Ushbu Firebase loyiha o‘chirilgan.'
};