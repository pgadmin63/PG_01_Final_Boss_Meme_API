
INSERT INTO users (id, display_name, avatar_url)
VALUES
('user_demo_001', 'Demo Player', 'https://example.com/avatar/demo.png'),
('user_demo_002', 'Meme Lord', 'https://example.com/avatar/meme.png');

INSERT INTO bosses (
  id,
  user_id,
  name,
  title,
  style,
  difficulty,
  description,
  image_prompt,
  original_image_url,
  generated_image_url,
  thumbnail_url,
  share_slug,
  likes_count,
  views_count,
  downloads_count
)
VALUES
(
  'boss_001',
  'user_demo_001',
  'Chúa Tể Deadline',
  'Kẻ Seen Tin Nhắn Bất Tử',
  'Dark Souls',
  'Nightmare',
  'Một final boss sinh ra từ deadline, cà phê đá và những tin nhắn chưa từng được trả lời.',
  'Create a Dark Souls style final boss inspired by a tired office worker, cinematic lighting, massive aura, cursed armor, dramatic background.',
  'https://example.com/uploads/boss_001_original.png',
  'https://example.com/generated/boss_001.png',
  'https://example.com/thumbnails/boss_001.png',
  'chua-te-deadline',
  128,
  3200,
  560
),
(
  'boss_002',
  'user_demo_002',
  'Cyber Simp Overlord',
  'Người Gác Cổng Friendzone',
  'Cyberpunk',
  'Impossible',
  'Một thực thể cyberpunk sống bằng seen story, thả tim dạo và hy vọng mong manh.',
  'Create a cyberpunk anime final boss with neon lights, broken heart holograms, futuristic armor, meme energy.',
  'https://example.com/uploads/boss_002_original.png',
  'https://example.com/generated/boss_002.png',
  'https://example.com/thumbnails/boss_002.png',
  'cyber-simp-overlord',
  999,
  12000,
  2400
);

INSERT INTO boss_stats (
  id,
  boss_id,
  label,
  value,
  max_value,
  unit,
  display_order,
  is_overflow
)
VALUES
('stat_001', 'boss_001', 'Độ báo đời', '999', '100', '%', 1, 1),
('stat_002', 'boss_001', 'Khả năng né deadline', '∞', '100', 'aura', 2, 1),
('stat_003', 'boss_001', 'Tỉ lệ seen không rep', '404', '100', '%', 3, 1),
('stat_004', 'boss_001', 'Năng lượng cà khịa', '87', '100', '%', 4, 0),

('stat_005', 'boss_002', 'Độ simp', '9999', '100', '%', 1, 1),
('stat_006', 'boss_002', 'Aura phản diện', 'ERROR', '100', '', 2, 1),
('stat_007', 'boss_002', 'Khả năng thả tim dạo', '∞', '999', 'lần/ngày', 3, 1),
('stat_008', 'boss_002', 'Sát thương tinh thần', '120', '100', '%', 4, 1);

INSERT INTO boss_skills (
  id,
  boss_id,
  name,
  description,
  cooldown,
  display_order
)
VALUES
('skill_001', 'boss_001', 'Seen Không Rep EX', 'Gây 999 sát thương tinh thần cho toàn bộ party.', 'mỗi khi bạn cần nó nhất', 1),
('skill_002', 'boss_001', 'Deadline Vanish', 'Tàng hình khỏi mọi task, issue và group chat công việc.', 'thứ Hai hàng tuần', 2),
('skill_003', 'boss_001', 'Cà Khịa Diện Rộng', 'Giảm 50% tự tin của đối phương bằng một câu nói nhẹ nhàng.', 'luôn bật', 3),

('skill_004', 'boss_002', 'Friendzone Firewall', 'Chặn toàn bộ tín hiệu tình cảm đi vào trái tim boss.', 'vĩnh viễn', 1),
('skill_005', 'boss_002', 'Story Hunter', 'Tự động xem story sau 0.2 giây và không để lại dấu vết.', 'mỗi 5 phút', 2),
('skill_006', 'boss_002', 'Hope.exe Crash', 'Làm sập toàn bộ hy vọng của đối phương bằng một chữ "ừ".', 'ERROR', 3);

INSERT INTO leaderboard (
  id,
  boss_id,
  score,
  rank_type,
  period
)
VALUES
('lb_001', 'boss_001', 3888, 'most_cursed', 'all_time'),
('lb_002', 'boss_002', 9999, 'most_cursed', 'all_time'),
('lb_003', 'boss_001', 560, 'most_downloaded', 'all_time'),
('lb_004', 'boss_002', 2400, 'most_downloaded', 'all_time');

INSERT INTO daily_boss (
  id,
  boss_id,
  selected_date,
  reason
)
VALUES
(
  'daily_001',
  'boss_002',
  '2026-05-12',
  'Chỉ số simp vượt giới hạn vật lý, phù hợp làm boss đại diện hôm nay.'
);

INSERT INTO generation_logs (
  id,
  user_id,
  boss_id,
  provider,
  model,
  status,
  input_tokens,
  output_tokens,
  error_message
)
VALUES
('log_001', 'user_demo_001', 'boss_001', 'gemini', 'gemini-2.5-flash', 'success', 1200, 650, NULL),
('log_002', 'user_demo_002', 'boss_002', 'gemini', 'gemini-2.5-flash', 'success', 1350, 720, NULL);