-- Harness v0 schema - migration 006
-- Self-Harness failure attribution, regression evaluation, and trace trees.

ALTER TABLE trace ADD COLUMN work_item_id TEXT REFERENCES work_item(id);
ALTER TABLE trace ADD COLUMN parent_trace_id INTEGER REFERENCES trace(id);

CREATE TABLE failure_pattern (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at  TEXT NOT NULL DEFAULT (datetime('now')),
    signature   TEXT NOT NULL,
    category    TEXT NOT NULL CHECK(category IN (
                  'missing_story_packet',
                  'missing_validation',
                  'missing_artifact',
                  'context_gap',
                  'tool_retry_loop',
                  'scope_expansion',
                  'verification_skipped',
                  'unlinked_work_state'
                )),
    summary     TEXT NOT NULL,
    evidence    TEXT,
    status      TEXT NOT NULL DEFAULT 'observed'
                CHECK(status IN ('observed','proposed','mitigated','accepted_risk')),
    UNIQUE(signature, category)
);

CREATE TABLE trace_failure (
    trace_id            INTEGER NOT NULL REFERENCES trace(id),
    failure_pattern_id  INTEGER NOT NULL REFERENCES failure_pattern(id),
    causal_status       TEXT NOT NULL CHECK(causal_status IN ('root','contributing','symptom')),
    verifier_grounded   INTEGER NOT NULL DEFAULT 0 CHECK(verifier_grounded IN (0,1)),
    notes               TEXT,
    PRIMARY KEY(trace_id, failure_pattern_id)
);

CREATE TABLE proposal (
    id                 INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at          TEXT NOT NULL DEFAULT (datetime('now')),
    title              TEXT NOT NULL,
    component          TEXT NOT NULL,
    failure_pattern_id INTEGER REFERENCES failure_pattern(id),
    evidence           TEXT NOT NULL,
    candidate_change   TEXT NOT NULL,
    predicted_impact   TEXT NOT NULL,
    risk               TEXT NOT NULL CHECK(risk IN ('tiny','normal','high_risk')),
    validation_plan    TEXT NOT NULL,
    acceptance_gate    TEXT NOT NULL,
    confidence         TEXT NOT NULL CHECK(confidence IN ('low','medium','high')),
    status             TEXT NOT NULL DEFAULT 'proposed'
                       CHECK(status IN ('proposed','promoted','rejected')),
    backlog_id         INTEGER REFERENCES backlog(id)
);

CREATE TABLE eval_case (
    id              TEXT PRIMARY KEY,
    name            TEXT NOT NULL,
    split           TEXT NOT NULL CHECK(split IN ('held_in','held_out')),
    command         TEXT NOT NULL,
    expected_result TEXT NOT NULL DEFAULT 'pass'
                    CHECK(expected_result IN ('pass','fail')),
    component       TEXT NOT NULL,
    notes           TEXT
);

CREATE TABLE eval_run (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    proposal_id INTEGER REFERENCES proposal(id),
    case_id     TEXT NOT NULL REFERENCES eval_case(id),
    result      TEXT NOT NULL CHECK(result IN ('pass','fail','skipped')),
    stdout      TEXT,
    stderr      TEXT,
    created_at  TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX idx_trace_work_item ON trace(work_item_id);
CREATE INDEX idx_trace_parent ON trace(parent_trace_id);
CREATE INDEX idx_trace_failure_pattern ON trace_failure(failure_pattern_id);
CREATE INDEX idx_eval_run_proposal ON eval_run(proposal_id);

INSERT INTO schema_version (version) VALUES (6);
