extension StringExtension on String {
  bool get isImage {
    try {
      final extensions = ["png", "jpg", "jpeg", "heic", "gif"];
      return extensions.contains(split(".").last.toLowerCase());
    } catch (e) {
      return false;
    }
  }

  bool get isDoc {
    try {
      final extensions = ["doc", "docx", "pdf"];
      return extensions.contains(split(".").last.toLowerCase());
    } catch (e) {
      return false;
    }
  }

  bool get isAudio {
    try {
      final extensions = ["mp3"];
      return extensions.contains(split(".").last.toLowerCase());
    } catch (e) {
      return false;
    }
  }

  bool get isVideo {
    try {
      final extensions = [
        "mp4",
        "mov",
        "avi",
        "mkv",
        "webm",
        "wmv",
        "flv",
        "3gp",
        "m4v",
        'srt',
        'vtt',
      ];
      return extensions.contains(split(".").last.toLowerCase());
    } catch (e) {
      return false;
    }
  }
}
