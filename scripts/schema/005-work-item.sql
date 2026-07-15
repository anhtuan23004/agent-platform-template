-- Harness v0 schema - migration 005
-- Hierarchical work breakdown from spec to epic, story/spike, and task.

CREATE TABLE work_item (
    id                  TEXT PRIMARY KEY,   -- e.g. SPEC-001, E01, US-001, SP-001, T001
    parent_id           TEXT REFERENCES work_item(id),
    type                TEXT NOT NULL
                        CHECK(type IN ('spec','epic','story','spike','task')),
    title               TEXT NOT NULL,
    created_at          TEXT NOT NULL DEFAULT (datetime('now')),
    status              TEXT NOT NULL DEFAULT 'draft'
                        CHECK(status IN (
                          'draft','ready','in_progress','blocked','done',
                          'changed','retired'
                        )),
    risk_lane           TEXT CHECK(risk_lane IN ('tiny','normal','high_risk') OR risk_lane IS NULL),
    scope               TEXT,
    out_of_scope        TEXT,
    optional_scope      TEXT,
    acceptance_criteria TEXT,
    doc_path            TEXT,
    evidence            TEXT,
    notes               TEXT
);

CREATE INDEX idx_work_item_parent ON work_item(parent_id);
CREATE INDEX idx_work_item_type ON work_item(type);
CREATE INDEX idx_work_item_status ON work_item(status);

INSERT INTO schema_version (version) VALUES (5);
