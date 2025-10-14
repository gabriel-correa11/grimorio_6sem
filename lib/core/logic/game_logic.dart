class GameLogic {
  static const Map<int, String> levelTitles = {
    1: 'Aprendiz',
    2: 'Escrivão',
    3: 'Letrado',
    4: 'Feiticeiro',
    5: 'Mago',
    6: 'Arquimago',
    7: 'Sábio',
    8: 'Iluminado',
    9: 'Lendário',
    10: 'Supremo',
  };

  static const Map<int, int> xpPerLevel = {
    1: 100,
    2: 250,
    3: 500,
    4: 1000,
    5: 2000,
    6: 4000,
    7: 8000,
    8: 16000,
    9: 32000,
    10: 64000,
  };

  static String getTitleForLevel(int level) {
    return levelTitles[level] ?? 'Aprendiz';
  }

  static int getLevelForXp(int xp) {
    if (xp < 100) return 1;
    if (xp < 250) return 2;
    if (xp < 500) return 3;
    if (xp < 1000) return 4;
    if (xp < 2000) return 5;
    if (xp < 4000) return 6;
    if (xp < 8000) return 7;
    if (xp < 16000) return 8;
    if (xp < 32000) return 9;
    return 10;
  }
}