# Production Decision 003 — Choose the P0 Asset and Scene Pipeline

**Type:** Wayfinder research decision  
**Status:** closed  
**Blocked by:** Production Decision 001  
**Blocks:** P0 authored-cove and asset tickets

## Question

How should a solo developer acquire, transform, license, and render realistic cove content without creating an unmaintainable or legally ambiguous asset pile?

## Resolution

- Author the compact cove through Blender→glTF scenes/resources rather than adding a full terrain system in P0.
- Default to Poly Haven and ambientCG CC0 assets; self-created assets are also allowed. Every asset receives provenance even when attribution is optional.
- Permit MIT/BSD/Apache/Zlib dependencies with required notices. Paid or custom-license assets require separate approval before acquisition.
- Mixamo is temporary evaluation content only until the final character pipeline is decided; archive sources and record Adobe's applicable terms.
- Freesound ingestion defaults to CC0. CC-BY requires complete attribution; non-commercial and incompatible share-alike assets are rejected.
- Use 2K textures by default, 4K only for documented hero exceptions, automatic mesh LOD on imported scenes, manual LOD for broken/critical meshes, MultiMesh for repetition, and HLOD/visibility ranges where evidence shows value.
- Evaluate MIT Terrain3D only at the later full-map gate; its GDExtension/export/version cost is unnecessary for the compact cove.

## Evidence

Poly Haven and ambientCG explicitly license downloadable assets CC0. Blender states created artwork belongs to its creator and may be used commercially. Terrain3D is active, MIT, and has a current stable release, but P0 does not need its full-map capability.

## Consequence

The coder can acquire free realistic content without further taste decisions, while a provenance validator and texture/LOD budgets prevent silent legal or performance debt.
