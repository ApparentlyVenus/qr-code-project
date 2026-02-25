CREATE DATABASE IF NOT EXISTS school_qr;
USE school_qr;

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS school_qr;
USE school_qr;

-- Students table
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    grade VARCHAR(10),
    has_access BOOLEAN DEFAULT false,
    photo_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_student_id (student_id),
    INDEX idx_access (has_access)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- QR codes table
CREATE TABLE IF NOT EXISTS qr_codes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    qr_hash VARCHAR(255) UNIQUE NOT NULL,
    qr_data TEXT NOT NULL,
    active BOOLEAN DEFAULT true,
    expires_at DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    INDEX idx_qr_hash (qr_hash),
    INDEX idx_active_expires (active, expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Scans log table
CREATE TABLE IF NOT EXISTS scans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    qr_id INT NOT NULL,
    student_id INT NOT NULL,
    scanned_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    direction ENUM('in', 'out') NOT NULL,
    allowed BOOLEAN NOT NULL,
    scanner_location VARCHAR(50),
    FOREIGN KEY (qr_id) REFERENCES qr_codes(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    INDEX idx_scanned_at (scanned_at),
    INDEX idx_student_scans (student_id, scanned_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample data
INSERT INTO students (student_id, full_name, grade, has_access) VALUES
('2024001', 'John Doe', '11th', true),
('2024002', 'Jane Smith', '12th', false),
('2024003', 'Bob Johnson', '10th', true);