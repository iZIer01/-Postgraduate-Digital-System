-- =============================================================================
-- NUST Supervisor Module - MySQL Database Schema
-- Laravel + React + TypeScript Application
-- =============================================================================

-- =============================================================================

SET FOREIGN_KEY_CHECKS = 0;



-- -----------------------------------------------------------------------------
-- 2. supervisor_profiles  (supervisor module)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `supervisor_profiles` (
    `id`                  CHAR(36)     NOT NULL,
    `user_id`             CHAR(36)     NOT NULL,
    `job_title`           VARCHAR(150) NULL,
    `title`               VARCHAR(50)  NULL COMMENT 'e.g. Prof., Dr., Mr.',
    `affiliation`         VARCHAR(255) NULL,
    `office_address`      TEXT         NULL,
    `postal_address`      TEXT         NULL,
    `account_created_at`  TIMESTAMP    NULL,
    `source_system`       VARCHAR(100) NULL,
    `updated_at`          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `supervisor_profiles_user_id_unique` (`user_id`),
    CONSTRAINT `fk_supervisor_profiles_user`
        FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 3. supervision_relationships  (supervisor <-> student)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `supervision_relationships` (
    `id`                CHAR(36)     NOT NULL,
    `supervisor_id`     CHAR(36)     NOT NULL,
    `student_id`        CHAR(36)     NOT NULL,
    `co_supervisor_id`  CHAR(36)     NULL,
    `assigned_at`       TIMESTAMP    NULL,
    `status`            VARCHAR(50)  NOT NULL DEFAULT 'active' COMMENT 'active, completed, terminated',
    `updated_at`        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_suprel_supervisor`
        FOREIGN KEY (`supervisor_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_suprel_student`
        FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_suprel_co_supervisor`
        FOREIGN KEY (`co_supervisor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 4. pg_applications  (student module — postgraduate applications)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `pg_applications` (
    `id`                CHAR(36)     NOT NULL,
    `student_id`        CHAR(36)     NOT NULL,
    `status`            VARCHAR(50)  NOT NULL DEFAULT 'draft' COMMENT 'draft, submitted, approved, rejected',
    `submitted_at`      TIMESTAMP    NULL,
    `motivation_letter` TEXT         NULL,
    `academic_level`    VARCHAR(50)  NULL COMMENT 'honours, masters, phd',
    `updated_at`        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_pg_applications_student`
        FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 5. submissions  (core entity — proposals, theses, etc.)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `submissions` (
    `id`                      CHAR(36)     NOT NULL,
    `student_id`              CHAR(36)     NOT NULL,
    `supervisor_id`           CHAR(36)     NOT NULL,
    `co_supervisor_id`        CHAR(36)     NULL,
    `type`                    VARCHAR(80)  NOT NULL COMMENT 'proposal, thesis, progress_report, etc.',
    `title`                   VARCHAR(500) NOT NULL,
    `academic_level`          VARCHAR(50)  NULL,
    `status`                  VARCHAR(50)  NOT NULL DEFAULT 'draft',
    `supervisor_feedback`     TEXT         NULL,
    `supervisor_decision`     VARCHAR(50)  NULL COMMENT 'approved, revisions_required, rejected',
    `supervisor_signed_at`    TIMESTAMP    NULL,
    `created_at`              TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `submitted_at`            TIMESTAMP    NULL,
    `updated_at`              TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_submissions_student`
        FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_submissions_supervisor`
        FOREIGN KEY (`supervisor_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_submissions_co_supervisor`
        FOREIGN KEY (`co_supervisor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 6. document_versions  (versioned submission files)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `document_versions` (
    `id`             CHAR(36)     NOT NULL,
    `submission_id`  CHAR(36)     NOT NULL,
    `version_number` INT UNSIGNED NOT NULL DEFAULT 1,
    `file_key`       VARCHAR(500) NOT NULL COMMENT 'S3 / storage key',
    `file_type`      VARCHAR(20)  NOT NULL COMMENT 'pdf, docx, etc.',
    `uploaded_by`    CHAR(36)     NOT NULL,
    `created_at`     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_docver_submission`
        FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_docver_uploader`
        FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 7. proposal_checklists  (supervisor checklist on proposals)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `proposal_checklists` (
    `id`                    CHAR(36)     NOT NULL,
    `submission_id`         CHAR(36)     NOT NULL,
    `supervisor_id`         CHAR(36)     NOT NULL,
    `student_id`            CHAR(36)     NOT NULL,
    `item_description`      TEXT         NOT NULL,
    `item_status`           VARCHAR(50)  NOT NULL DEFAULT 'pending' COMMENT 'pending, satisfied, not_satisfied',
    `supervisor_signoff_at` TIMESTAMP    NULL,
    `supervisor_comments`   TEXT         NULL,
    `date_signed`           TIMESTAMP    NULL,
    `updated_at`            TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_checklist_submission`
        FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_checklist_supervisor`
        FOREIGN KEY (`supervisor_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_checklist_student`
        FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 8. progress_reports  (periodic student progress)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `progress_reports` (
    `id`                   CHAR(36)     NOT NULL,
    `student_id`           CHAR(36)     NOT NULL,
    `supervisor_id`        CHAR(36)     NOT NULL,
    `period`               VARCHAR(50)  NOT NULL COMMENT 'e.g. 2024-Q1',
    `status`               VARCHAR(50)  NOT NULL DEFAULT 'draft',
    `supervisor_comment`   TEXT         NULL,
    `supervisor_signed_at` TIMESTAMP    NULL,
    `hdc_feedback`         TEXT         NULL,
    `submitted_at`         TIMESTAMP    NULL,
    `updated_at`           TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_progrep_student`
        FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_progrep_supervisor`
        FOREIGN KEY (`supervisor_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 9. thesis_evaluations  (FPGC-R / evaluator module)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `thesis_evaluations` (
    `id`                          CHAR(36)     NOT NULL,
    `submission_id`               CHAR(36)     NOT NULL,
    `supervisor_id`               CHAR(36)     NOT NULL,
    `student_id`                  CHAR(36)     NOT NULL,
    `scientific_field_relevance`  TEXT         NULL,
    `aims_objectives_hypothesis`  TEXT         NULL,
    `chapter_assessment`          TEXT         NULL,
    `overall_judgment`            TEXT         NULL,
    `intellectual_merit_score`    TINYINT UNSIGNED NULL,
    `intellectual_merit_comments` TEXT         NULL,
    `scientific_merit_score`      TINYINT UNSIGNED NULL,
    `scientific_merit_comments`   TEXT         NULL,
    `results_quality_score`       TINYINT UNSIGNED NULL,
    `results_comments`            TEXT         NULL,
    `presentation_score`          TINYINT UNSIGNED NULL,
    `presentation_comments`       TEXT         NULL,
    `creativity_score`            TINYINT UNSIGNED NULL,
    `creativity_comments`         TEXT         NULL,
    `total_marks`                 SMALLINT UNSIGNED NULL,
    `percentage`                  DECIMAL(5,2) NULL,
    `recommendation`              VARCHAR(100) NULL,
    `distinction_objection`       TINYINT(1)   NOT NULL DEFAULT 0,
    `disclosure_permission`       TINYINT(1)   NOT NULL DEFAULT 0,
    `sections_to_share`           TEXT         NULL,
    `status`                      VARCHAR(50)  NOT NULL DEFAULT 'pending',
    `signed_at`                   TIMESTAMP    NULL,
    `created_at`                  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_thesiseval_submission`
        FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_thesiseval_supervisor`
        FOREIGN KEY (`supervisor_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_thesiseval_student`
        FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 10. oral_evaluations  (oral defence scores)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `oral_evaluations` (
    `id`                  CHAR(36)        NOT NULL,
    `submission_id`       CHAR(36)        NOT NULL,
    `supervisor_id`       CHAR(36)        NOT NULL,
    `student_id`          CHAR(36)        NOT NULL,
    `structure_score`     TINYINT UNSIGNED NULL,
    `focus_score`         TINYINT UNSIGNED NULL,
    `understanding_score` TINYINT UNSIGNED NULL,
    `discussion_score`    TINYINT UNSIGNED NULL,
    `slide_quality_score` TINYINT UNSIGNED NULL,
    `slide_quantity_score`TINYINT UNSIGNED NULL,
    `intro_score`         TINYINT UNSIGNED NULL,
    `preparation_score`   TINYINT UNSIGNED NULL,
    `appearance_score`    TINYINT UNSIGNED NULL,
    `speech_score`        TINYINT UNSIGNED NULL,
    `oral_total_marks`    SMALLINT UNSIGNED NULL,
    `evaluator_comments`  TEXT            NULL,
    `status`              VARCHAR(50)     NOT NULL DEFAULT 'pending',
    `created_at`          TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_oraleval_submission`
        FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_oraleval_supervisor`
        FOREIGN KEY (`supervisor_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_oraleval_student`
        FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 11. summary_of_proposals  (HoD module — proposal summaries)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `summary_of_proposals` (
    `id`                       CHAR(36) NOT NULL,
    `submission_id`            CHAR(36) NOT NULL,
    `supervisor_id`            CHAR(36) NOT NULL,
    `student_id`               CHAR(36) NOT NULL,
    `hod_id`                   CHAR(36) NULL,
    `background_to_study`      TEXT     NULL,
    `problem_statement`        TEXT     NULL,
    `objectives`               TEXT     NULL,
    `research_questions`       TEXT     NULL,
    `literature_review`        TEXT     NULL,
    `theoretical_framework`    TEXT     NULL,
    `research_design`          TEXT     NULL,
    `data_collection_methods`  TEXT     NULL,
    `data_analysis_methods`    TEXT     NULL,
    `ethical_issues`           TEXT     NULL,
    `limitations`              TEXT     NULL,
    `significance`             TEXT     NULL,
    `beneficiaries`            TEXT     NULL,
    `references`               TEXT     NULL,
    `hod_comments`             TEXT     NULL,
    `student_signature_at`     TIMESTAMP NULL,
    `supervisor_signature_at`  TIMESTAMP NULL,
    `hod_signature_at`         TIMESTAMP NULL,
    `created_at`               TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`               TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_sop_submission`
        FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_sop_supervisor`
        FOREIGN KEY (`supervisor_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_sop_student`
        FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_sop_hod`
        FOREIGN KEY (`hod_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 12. honorarium_claims  (supervisor honorarium)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `honorarium_claims` (
    `id`             CHAR(36)     NOT NULL,
    `submission_id`  CHAR(36)     NOT NULL,
    `supervisor_id`  CHAR(36)     NOT NULL,
    `student_id`     CHAR(36)     NOT NULL,
    `claim_file_key` VARCHAR(500) NULL COMMENT 'S3 / storage key for the claim document',
    `status`         VARCHAR(50)  NOT NULL DEFAULT 'pending' COMMENT 'pending, submitted, approved, paid',
    `created_at`     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_honclaim_submission`
        FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_honclaim_supervisor`
        FOREIGN KEY (`supervisor_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_honclaim_student`
        FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 13. evaluator_assignments  (FPGC-R assigns evaluators)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `evaluator_assignments` (
    `id`             CHAR(36)     NOT NULL,
    `submission_id`  CHAR(36)     NOT NULL,
    `evaluator_id`   CHAR(36)     NOT NULL,
    `evaluator_type` VARCHAR(80)  NOT NULL COMMENT 'internal, external',
    `assigned_at`    TIMESTAMP    NULL,
    `deadline`       TIMESTAMP    NULL,
    `status`         VARCHAR(50)  NOT NULL DEFAULT 'pending' COMMENT 'pending, accepted, completed, declined',
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_evalassign_submission`
        FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_evalassign_evaluator`
        FOREIGN KEY (`evaluator_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 14. hdc_presentations  (Higher Degrees Committee presentations)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `hdc_presentations` (
    `id`            CHAR(36)     NOT NULL,
    `submission_id` CHAR(36)     NOT NULL,
    `fpgcr_id`      CHAR(36)     NOT NULL COMMENT 'FPGC-R coordinator who scheduled',
    `scheduled_at`  TIMESTAMP    NULL,
    `outcome`       VARCHAR(80)  NULL COMMENT 'pass, fail, revision',
    `outcome_notes` TEXT         NULL,
    `created_at`    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_hdcpres_submission`
        FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_hdcpres_fpgcr`
        FOREIGN KEY (`fpgcr_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 15. notifications  (shared — in-app alerts)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `notifications` (
    `id`         CHAR(36)     NOT NULL,
    `user_id`    CHAR(36)     NOT NULL,
    `type`       VARCHAR(100) NOT NULL COMMENT 'e.g. submission_approved, report_due',
    `message`    TEXT         NOT NULL,
    `read_at`    TIMESTAMP    NULL,
    `created_at` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_notif_user`
        FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------------------------------
-- 16. audit_logs  (shared — immutable action log)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `audit_logs` (
    `id`          CHAR(36)     NOT NULL,
    `actor_id`    CHAR(36)     NOT NULL COMMENT 'user who performed the action',
    `entity_type` VARCHAR(100) NOT NULL COMMENT 'table/model name, e.g. submissions',
    `entity_id`   CHAR(36)     NOT NULL COMMENT 'PK of the affected record',
    `action`      VARCHAR(50)  NOT NULL COMMENT 'created, updated, deleted, signed, etc.',
    `ip_address`  VARCHAR(45)  NULL COMMENT 'IPv4 or IPv6',
    `created_at`  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_auditlog_actor`
        FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- Indexes for common query patterns
-- =============================================================================

-- supervision_relationships
CREATE INDEX `idx_suprel_student`    ON `supervision_relationships` (`student_id`);
CREATE INDEX `idx_suprel_supervisor` ON `supervision_relationships` (`supervisor_id`);

-- submissions
CREATE INDEX `idx_submissions_student`    ON `submissions` (`student_id`);
CREATE INDEX `idx_submissions_supervisor` ON `submissions` (`supervisor_id`);
CREATE INDEX `idx_submissions_status`     ON `submissions` (`status`);
CREATE INDEX `idx_submissions_type`       ON `submissions` (`type`);

-- progress_reports
CREATE INDEX `idx_progrep_student`    ON `progress_reports` (`student_id`);
CREATE INDEX `idx_progrep_supervisor` ON `progress_reports` (`supervisor_id`);

-- thesis_evaluations
CREATE INDEX `idx_thesiseval_submission` ON `thesis_evaluations` (`submission_id`);

-- oral_evaluations
CREATE INDEX `idx_oraleval_submission`   ON `oral_evaluations` (`submission_id`);

-- evaluator_assignments
CREATE INDEX `idx_evalassign_evaluator`  ON `evaluator_assignments` (`evaluator_id`);

-- notifications
CREATE INDEX `idx_notif_user_unread`     ON `notifications` (`user_id`, `read_at`);

-- audit_logs
CREATE INDEX `idx_audit_entity`          ON `audit_logs` (`entity_type`, `entity_id`);
CREATE INDEX `idx_audit_actor`           ON `audit_logs` (`actor_id`);

SET FOREIGN_KEY_CHECKS = 1;

-- =============================================================================
-- END OF SCHEMA
-- =============================================================================
