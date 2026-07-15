# shared-crypto

Envelope encryption — KMS-backed data-key wrapping cho credentials at rest,
local dev key fallback. Dùng bởi `integrations` trước khi persist secret.


## Public surface (planned)

| Entry | Purpose |
|---|---|
| `shared-crypto` | Seal/open blobs, provider config |
| `shared-crypto/testing` | Local key fixtures |
