// lib/data/pest_library_data.dart
//
// Static reference data for the Pest & Disease Library feature.
//
// NOTE: This content is compiled from general agricultural knowledge
// commonly documented by PhilRice / IRRI for Philippine rice farming.
// It has not been cross-checked against a specific research paper —
// please review it against your own sources (e.g. the UP research you
// mentioned) before publishing this to real farmers.

import '../models/pest_info.dart';

final List<PestInfo> pestLibraryData = [
  // ── PESTS ──────────────────────────────────────────────────────────────
  const PestInfo(
    id: 'bph',
    name: 'Brown Planthopper',
    localName: 'Kayumangging Ipis-dapo',
    scientificName: 'Nilaparvata lugens',
    type: PestType.pest,
    description:
        'A small, brown, plant-sap-sucking insect that clusters at the base '
        'of rice stems. One of the most destructive rice pests in Asia; can '
        'also transmit grassy stunt and ragged stunt viruses.',
    cause:
        'Thrives in warm, humid conditions. Populations explode with '
        'overuse of nitrogen fertilizer, dense planting, and overuse of '
        'insecticides that kill its natural predators (spiders, wasps).',
    symptoms:
        'Yellowing and drying of lower leaves, "hopperburn" — patches of '
        'field turning brown and dying as if scorched, stunted growth, '
        'reduced tillering.',
    prevention:
        'Plant resistant varieties, avoid excessive nitrogen, maintain '
        'proper plant spacing for airflow, preserve natural predators by '
        'limiting broad-spectrum insecticide use, monitor fields weekly '
        'during vegetative stage.',
  ),
  const PestInfo(
    id: 'black_bug',
    name: 'Rice Black Bug',
    localName: 'Itim na Susô ng Bigas',
    scientificName: 'Scotinophara coarctata',
    type: PestType.pest,
    description:
        'A dark brown to black bug that feeds on rice stems and leaf '
        'sheaths, especially active at the base of the plant at night.',
    cause:
        'Favors continuous rice cropping without fallow periods, and '
        'weedy or grassy areas near fields that shelter the bugs between '
        'seasons.',
    symptoms:
        '"Bugburn" — orange to reddish-brown discoloration and drying of '
        'leaves, stunted plants, empty or partially filled grains, whole '
        'patches of the field appearing scorched.',
    prevention:
        'Practice synchronous planting with neighboring farms, clear '
        'grassy borders and weeds, use light traps to monitor and reduce '
        'adult populations, rotate crops when possible.',
  ),
  const PestInfo(
    id: 'golden_snail',
    name: 'Golden Apple Snail',
    localName: 'Kuhol',
    scientificName: 'Pomacea canaliculata',
    type: PestType.pest,
    description:
        'A freshwater snail with a golden-to-brown shell that feeds '
        'voraciously on young rice seedlings. Considered one of the '
        'worst invasive species affecting Philippine rice paddies.',
    cause:
        'Introduced decades ago as a food source and spread widely '
        'through irrigation canals; thrives in flooded, standing water '
        'conditions typical of transplanted or wet-seeded rice.',
    symptoms:
        'Seedlings cut near the base and floating, missing plants leaving '
        'gaps in rows, pink egg clusters visible on stems or canal walls '
        'above the waterline.',
    prevention:
        'Hand-pick snails and egg masses, keep field water shallow during '
        'the first 2–3 weeks after transplanting, use screens on inlet '
        'canals, encourage ducks in fields after establishment, use '
        'molluscicides only as a last resort.',
  ),
  const PestInfo(
    id: 'rice_bug',
    name: 'Rice Bug',
    localName: 'Kayumanggi',
    scientificName: 'Leptocorisa oratorius',
    type: PestType.pest,
    description:
        'A slender, brownish-green bug with a strong odor that feeds by '
        'sucking sap directly from developing rice grains during the '
        'milky stage.',
    cause:
        'Attracted to flowering rice and grassy weeds nearby; populations '
        'rise when nearby fields flower at staggered times, giving the '
        'bugs a continuous food source.',
    symptoms:
        'Grains with dark brown or black spots, unfilled or partially '
        'filled ("pecky") grains, chaffy panicles, foul odor around '
        'heavily infested plants.',
    prevention:
        'Synchronize planting dates with neighboring farms, remove grassy '
        'weeds and alternate host plants around field edges, use light '
        'or sweep-net traps to monitor bug density before spraying.',
  ),
  const PestInfo(
    id: 'stem_borer',
    name: 'Yellow Stem Borer',
    localName: 'Uod sa Puno ng Palay',
    scientificName: 'Scirpophaga incertulas',
    type: PestType.pest,
    description:
        'The larval stage of a moth that bores into the rice stem, '
        'feeding internally and cutting off the flow of nutrients to '
        'the growing point or panicle.',
    cause:
        'Moths lay eggs on leaves; larvae hatch and tunnel into stems. '
        'Continuous rice cropping and leftover stubble in the field let '
        'the pest survive between seasons.',
    symptoms:
        '"Deadheart" — the central shoot turns brown and dies during '
        'vegetative stage; "whitehead" — entire panicle turns white and '
        'empty during reproductive stage, pulls out easily when tugged.',
    prevention:
        'Plow under or burn rice stubble after harvest to destroy '
        'overwintering larvae, avoid staggered planting in the same '
        'area, use pheromone traps to monitor moth activity, plant '
        'resistant varieties.',
  ),
  const PestInfo(
    id: 'leaffolder',
    name: 'Rice Leaffolder',
    localName: 'Tagapiko ng Dahon',
    scientificName: 'Cnaphalocrocis medinalis',
    type: PestType.pest,
    description:
        'A caterpillar that folds and webs rice leaves together, feeding '
        'on the leaf surface inside the folded tube it creates.',
    cause:
        'Favored by lush, dense, nitrogen-heavy growth and moths migrating '
        'from grassy or weedy areas; humid, cloudy weather boosts moth '
        'survival.',
    symptoms:
        'Leaves rolled or folded lengthwise with visible webbing, white or '
        'transparent streaks where the caterpillar has scraped the leaf '
        'surface, ragged, scorched-looking canopy from a distance.',
    prevention:
        'Avoid excessive nitrogen application, keep field borders free of '
        'grassy weeds, encourage natural predators such as spiders and '
        'parasitic wasps, monitor and treat only when damage crosses an '
        'economic threshold.',
  ),
  const PestInfo(
    id: 'armyworm',
    name: 'Rice Armyworm',
    localName: 'Uod na Hukbo',
    scientificName: 'Mythimna separata',
    type: PestType.pest,
    description:
        'A caterpillar pest that moves in large groups ("armies"), '
        'rapidly stripping leaves and, in severe outbreaks, entire '
        'plants overnight.',
    cause:
        'Outbreaks often follow heavy rains after a dry spell, and moths '
        'can migrate long distances into a field from grassy or '
        'grain-crop areas.',
    symptoms:
        'Sudden, severe defoliation, ragged or completely eaten leaf '
        'edges, visible caterpillars clustering at the base of plants '
        'during the day, patches of bare stalks appearing almost '
        'overnight.',
    prevention:
        'Scout fields regularly especially after heavy rain, maintain '
        'clean field borders to reduce migration routes, act quickly with '
        'targeted control once armyworm bands are spotted, since '
        'outbreaks can spread fast.',
  ),
  const PestInfo(
    id: 'mole_cricket',
    name: 'Mole Cricket',
    localName: 'Kamkam / Kuliglig sa Lupa',
    scientificName: 'Gryllotalpa spp.',
    type: PestType.pest,
    description:
        'A burrowing insect that tunnels through soil at the base of '
        'seedlings, physically uprooting or severing young plants as it '
        'moves.',
    cause:
        'Prefers loose, moist soil typical of newly transplanted or '
        'freshly seeded fields; more active at night and during land '
        'preparation periods.',
    symptoms:
        'Seedlings uprooted or leaning with disturbed soil around the '
        'base, visible burrow holes near damaged plants, patchy stand '
        'establishment shortly after transplanting.',
    prevention:
        'Level and firm the soil well before planting, drain and dry the '
        'field briefly if an active infestation is found, use light traps '
        'at night to monitor adult activity, avoid leaving loose organic '
        'debris in the soil that attracts them.',
  ),

  // ── DISEASES ───────────────────────────────────────────────────────────
  const PestInfo(
    id: 'blast',
    name: 'Rice Blast',
    localName: 'Blas',
    scientificName: 'Magnaporthe oryzae (Pyricularia oryzae)',
    type: PestType.disease,
    description:
        'A fungal disease that can attack leaves, nodes, and panicles at '
        'any growth stage. Considered one of the most destructive rice '
        'diseases worldwide.',
    cause:
        'Fungal spores spread by wind and rain splash; favored by high '
        'humidity, prolonged leaf wetness, cool nights, and excessive '
        'nitrogen fertilization.',
    symptoms:
        'Diamond- or spindle-shaped lesions with gray centers and brown '
        'borders on leaves, neck rot causing panicles to break and turn '
        'white/empty, node infection causing the stem to snap.',
    prevention:
        'Use resistant varieties, avoid excess nitrogen, ensure proper '
        'field drainage, avoid dense planting, apply fungicide preventively '
        'in known blast-prone areas during humid seasons.',
  ),
  const PestInfo(
    id: 'blb',
    name: 'Bacterial Leaf Blight',
    localName: 'Bacterial Leaf Blight (BLB)',
    scientificName: 'Xanthomonas oryzae pv. oryzae',
    type: PestType.disease,
    description:
        'A bacterial disease causing water-soaked streaks that expand '
        'into large blighted areas on the leaf, often entering through '
        'wounds or natural openings.',
    cause:
        'Spreads through irrigation water, wind-driven rain, and '
        'contaminated tools or seeds; worsened by strong winds/typhoons '
        'that create leaf wounds, and by excessive nitrogen.',
    symptoms:
        'Water-soaked lesions starting at leaf tips or edges, turning '
        'yellow then grayish-white as they enlarge, "kresek" — whole '
        'seedlings wilting and dying under severe infection.',
    prevention:
        'Use certified, disease-free seeds, avoid excessive nitrogen, '
        'maintain good field drainage, avoid working in fields when leaves '
        'are wet, remove and destroy infected plant debris after harvest.',
  ),
  const PestInfo(
    id: 'tungro',
    name: 'Rice Tungro Disease',
    localName: 'Tungro',
    scientificName: 'Rice tungro virus complex (RTBV + RTSV)',
    type: PestType.disease,
    description:
        'A viral disease transmitted exclusively by the green leafhopper. '
        'Causes severe stunting and yield loss, and has caused major '
        'outbreaks in the Philippines historically.',
    cause:
        'Spread only through green leafhopper feeding, not through seed '
        'or soil; nearby infected fields and continuous host plants let '
        'the leafhopper carry the virus between plantings.',
    symptoms:
        'Yellow-orange discoloration starting from leaf tips, stunted and '
        'reduced tillering, delayed flowering, sterile or partially filled '
        'panicles.',
    prevention:
        'Plant resistant varieties, synchronize planting with neighboring '
        'farms to break the leafhopper\'s continuous food supply, control '
        'green leafhopper populations early, remove infected plants '
        'promptly (rogueing).',
  ),
  const PestInfo(
    id: 'sheath_blight',
    name: 'Sheath Blight',
    localName: 'Sheath Blight',
    scientificName: 'Rhizoctonia solani',
    type: PestType.disease,
    description:
        'A fungal disease affecting the leaf sheath near the water line, '
        'especially common in dense, high-nitrogen, high-yielding crops.',
    cause:
        'Fungus survives in soil and crop debris between seasons; '
        'favored by dense canopy, high humidity within the crop, and '
        'heavy nitrogen use.',
    symptoms:
        'Oval, grayish-green to straw-colored lesions with brown borders '
        'on the leaf sheath near the waterline, lesions merging and '
        'climbing up the plant in severe cases, lodging in advanced '
        'infections.',
    prevention:
        'Avoid overly dense planting, manage nitrogen carefully, improve '
        'field drainage and airflow, remove and destroy crop stubble '
        'after harvest, rotate with non-host crops when feasible.',
  ),
  const PestInfo(
    id: 'bakanae',
    name: 'Bakanae Disease',
    localName: 'Bakanae',
    scientificName: 'Fusarium fujikuroi',
    type: PestType.disease,
    description:
        'A seed-borne fungal disease that causes abnormal, excessive '
        'elongation of infected seedlings, making them appear taller and '
        'thinner than healthy plants.',
    cause:
        'Primarily seed-transmitted; also survives in soil and crop '
        'residue. Spreads more readily with contaminated seed stock and '
        'poor seed treatment practices.',
    symptoms:
        'Abnormally tall, pale-green, thin seedlings, reddish discoloration '
        'at the base of the stem, poor root development, plants that die '
        'before or shortly after transplanting.',
    prevention:
        'Use certified, disease-free seeds, treat seeds with hot water or '
        'approved fungicide seed treatment before sowing, remove and '
        'destroy infected seedlings promptly, avoid reusing seed from an '
        'infected crop.',
  ),
  const PestInfo(
    id: 'false_smut',
    name: 'False Smut',
    localName: 'False Smut',
    scientificName: 'Ustilaginoidea virens',
    type: PestType.disease,
    description:
        'A fungal disease that transforms individual rice grains into '
        'greenish-yellow to black spore balls, primarily a cosmetic and '
        'grain-quality issue rather than a whole-plant killer.',
    cause:
        'Fungal spores infect flowers during the flowering stage; '
        'favored by high humidity, frequent rain during flowering, and '
        'excessive nitrogen application.',
    symptoms:
        'Individual grains replaced by velvety, greenish-yellow balls that '
        'darken to black as they mature, affected grains larger than '
        'normal, reduced overall grain quality and market value.',
    prevention:
        'Avoid excessive nitrogen, especially late applications near '
        'flowering, use resistant varieties where available, avoid '
        'planting during periods of expected heavy rain at flowering, '
        'apply fungicide preventively in disease-prone areas.',
  ),
];