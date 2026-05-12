DROP TABLE IF EXISTS generation_logs;
DROP TABLE IF EXISTS daily_boss;
DROP TABLE IF EXISTS leaderboard;
DROP TABLE IF EXISTS boss_skills;
DROP TABLE IF EXISTS boss_stats;
DROP TABLE IF EXISTS bosses;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id TEXT PRIMARY KEY,
  display_name TEXT,
  avatar_url TEXT,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE bosses (
  id TEXT PRIMARY KEY,
  user_id TEXT,
  name TEXT NOT NULL,
  title TEXT,
  style TEXT NOT NULL,
  difficulty TEXT NOT NULL,
  description TEXT,
  image_prompt TEXT,
  original_image_url TEXT,
  generated_image_url TEXT,
  thumbnail_url TEXT,
  share_slug TEXT UNIQUE,
  likes_count INTEGER NOT NULL DEFAULT 0,
  views_count INTEGER NOT NULL DEFAULT 0,
  downloads_count INTEGER NOT NULL DEFAULT 0,
  is_public INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE boss_stats (
  id TEXT PRIMARY KEY,
  boss_id TEXT NOT NULL,
  label TEXT NOT NULL,
  value TEXT NOT NULL,
  max_value TEXT,
  unit TEXT,
  display_order INTEGER NOT NULL DEFAULT 0,
  is_overflow INTEGER NOT NULL DEFAULT 0,

  FOREIGN KEY (boss_id) REFERENCES bosses(id) ON DELETE CASCADE
);

CREATE TABLE boss_skills (
  id TEXT PRIMARY KEY,
  boss_id TEXT NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  cooldown TEXT,
  display_order INTEGER NOT NULL DEFAULT 0,

  FOREIGN KEY (boss_id) REFERENCES bosses(id) ON DELETE CASCADE
);

CREATE TABLE leaderboard (
  id TEXT PRIMARY KEY,
  boss_id TEXT NOT NULL,
  score INTEGER NOT NULL DEFAULT 0,
  rank_type TEXT NOT NULL,
  period TEXT NOT NULL DEFAULT 'all_time',
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (boss_id) REFERENCES bosses(id) ON DELETE CASCADE
);

CREATE TABLE daily_boss (
  id TEXT PRIMARY KEY,
  boss_id TEXT NOT NULL,
  selected_date TEXT NOT NULL UNIQUE,
  reason TEXT,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (boss_id) REFERENCES bosses(id)
);

CREATE TABLE generation_logs (
  id TEXT PRIMARY KEY,
  user_id TEXT,
  boss_id TEXT,
  provider TEXT NOT NULL,
  model TEXT NOT NULL,
  status TEXT NOT NULL,
  input_tokens INTEGER DEFAULT 0,
  output_tokens INTEGER DEFAULT 0,
  error_message TEXT,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (boss_id) REFERENCES bosses(id)
);

CREATE INDEX idx_bosses_created_at ON bosses(created_at);
CREATE INDEX idx_bosses_share_slug ON bosses(share_slug);
CREATE INDEX idx_boss_stats_boss_id ON boss_stats(boss_id);
CREATE INDEX idx_boss_skills_boss_id ON boss_skills(boss_id);
CREATE INDEX idx_leaderboard_rank ON leaderboard(rank_type, period, score DESC);
CREATE INDEX idx_daily_boss_date ON daily_boss(selected_date);