-- Harness v0 schema - migration 007
-- Block story.status = 'implemented' without acceptance criteria and proof/waiver.
-- Remediates coverage illusion: durable rows must not claim done without evidence.

ALTER TABLE story ADD COLUMN proof_waiver TEXT;

-- Demote existing invalid "implemented" rows before installing the trigger.
UPDATE story
SET status = 'in_progress',
    notes = TRIM(
      COALESCE(notes, '') ||
      CASE
        WHEN COALESCE(notes, '') = '' THEN ''
        ELSE char(10)
      END ||
      '[auto] demoted from implemented: missing proof/waiver or acceptance criteria (migration 007)'
    )
WHERE status = 'implemented'
  AND (
    NOT (
      (
        COALESCE(unit_proof, 0)
        + COALESCE(integration_proof, 0)
        + COALESCE(e2e_proof, 0)
        + COALESCE(platform_proof, 0)
      ) > 0
      OR (
        proof_waiver IS NOT NULL
        AND length(trim(proof_waiver)) > 0
      )
    )
    OR evidence IS NULL
    OR length(trim(evidence)) = 0
    OR NOT EXISTS (
      SELECT 1
      FROM work_item wi
      WHERE wi.id = story.id
        AND wi.type IN ('story', 'spike')
        AND wi.acceptance_criteria IS NOT NULL
        AND length(trim(wi.acceptance_criteria)) > 0
    )
  );

CREATE TRIGGER story_implemented_requires_proof
BEFORE INSERT ON story
FOR EACH ROW
WHEN NEW.status = 'implemented'
BEGIN
  SELECT RAISE(
    ABORT,
    'story implemented requires acceptance_criteria on matching work_item and at least one proof flag or proof_waiver'
  )
  WHERE NOT (
    (
      COALESCE(NEW.unit_proof, 0)
      + COALESCE(NEW.integration_proof, 0)
      + COALESCE(NEW.e2e_proof, 0)
      + COALESCE(NEW.platform_proof, 0)
    ) > 0
    OR (
      NEW.proof_waiver IS NOT NULL
      AND length(trim(NEW.proof_waiver)) > 0
    )
  )
  OR NEW.evidence IS NULL
  OR length(trim(NEW.evidence)) = 0
  OR NOT EXISTS (
    SELECT 1
    FROM work_item wi
    WHERE wi.id = NEW.id
      AND wi.type IN ('story', 'spike')
      AND wi.acceptance_criteria IS NOT NULL
      AND length(trim(wi.acceptance_criteria)) > 0
  );
END;

CREATE TRIGGER story_implemented_requires_proof_update
BEFORE UPDATE OF status, unit_proof, integration_proof, e2e_proof,
                 platform_proof, evidence, proof_waiver ON story
FOR EACH ROW
WHEN NEW.status = 'implemented'
BEGIN
  SELECT RAISE(
    ABORT,
    'story implemented requires acceptance_criteria on matching work_item and at least one proof flag or proof_waiver'
  )
  WHERE NOT (
    (
      COALESCE(NEW.unit_proof, 0)
      + COALESCE(NEW.integration_proof, 0)
      + COALESCE(NEW.e2e_proof, 0)
      + COALESCE(NEW.platform_proof, 0)
    ) > 0
    OR (
      NEW.proof_waiver IS NOT NULL
      AND length(trim(NEW.proof_waiver)) > 0
    )
  )
  OR NEW.evidence IS NULL
  OR length(trim(NEW.evidence)) = 0
  OR NOT EXISTS (
    SELECT 1
    FROM work_item wi
    WHERE wi.id = NEW.id
      AND wi.type IN ('story', 'spike')
      AND wi.acceptance_criteria IS NOT NULL
      AND length(trim(wi.acceptance_criteria)) > 0
  );
END;

INSERT INTO schema_version (version) VALUES (7);
