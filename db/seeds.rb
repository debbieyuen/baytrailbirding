# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Location Seed Data

#facilities = Facility.create([{name: "Bathroom", icon: "https://cdn1.iconfinder.com/data/icons/construction-2-13/48/87-512.png"}])
locations = Location.create([{name: "Heron's Head Park",
							description: "Once slated to be a new shipping terminal in the 1970s, this slice of land ultimately became one of San
							Francisco’s natural gems thanks to a wetland restoration project in the 1990s. Heron’s Head Park is
							representative of what much of the San Francisco coastline once was: grassland uplands gently sloping
							into the pickleweed marsh bordering the bay. The pleasantly musical song of the many White-crowned
							Sparrows carries over the uplands, which are dotted with orange poppies in spring.",
							short_desc: "Once slated to be a new shipping terminal in the 1970s, this slice of land ultimately became one of San
							Francisco’s natural gems thanks to a wetland restoration project in the 1990s.",
							picURL: "https://sfport.com/sites/default/files/Planning/Images/Aerial%20Courtesey%20Bionic%20Landscape%20Architects-logo_0.png",
							websiteURL: "https://sfport.com/herons-head-park",
							longitude: "-122.37305445812652", latitude: "37.738335932140785"},
							{name: "Coyote Point Recreation Area",
							description: "This former site of an Ohlone fishing village now has a marina, a museum, and a eucalyptus forest. A
							variety of sea ducks can be seen around Coyote Point, some of which are harder to find elsewhere in the
							bay. Surf Scoters, scaup (especially Greater), and Common Goldeneyes are all approachable as they dive
							for mollusks just offshore. There is sometimes a Harlequin Duck roosting on the rocks below the bluffs.
							Black Turnstones and Surfbirds scour the rocky shoreline in fall and winter, as do a few Wandering
							Tattlers from late summer through fall. ",
							short_desc: "This former site of an Ohlone fishing village now has a marina, a museum, and a eucalyptus forest. A
							variety of sea ducks can be seen around Coyote Point, some of which are harder to find elsewhere in the
							bay.",
							websiteURL: "https://parks.smcgov.org/coyote-point-recreation-area",
							picURL: "https://parks.smcgov.org/sites/parks.smcgov.org/files/styles/flexslider_full/public/coyote-magicmountain1.jpg?itok=MknOQ_iX",
							longitude:"-122.318821", latitude:"37.587750"},

							{name: "Martin Luther King Jr. Regional Shoreline",
							description: "This park comprises much of the shoreline around San Leandro Bay, which is a small, sheltered area
							tucked behind Alameda and the Oakland Airport. Arrowhead Marsh is the prominent natural feature
							here. A boardwalk extending into the marsh provides one of the best opportunities to see the secretive
							Ridgway’s Rail as they emerge from the cordgrass to forage in the winding slough channels at low tide.",
							short_desc: "This park comprises much of the shoreline around San Leandro Bay, which is a small, sheltered area
							tucked behind Alameda and the Oakland Airport.",
							websiteURL: "https://www.ebparks.org/parks/martinlking/default.htm",
							picURL: "https://baynature.org/wp-content/uploads/2012/07/article-feature-captionimage(425).jpg",
 							latitude:"37.731010", longitude:"-122.208106"},

							{name: "Presidio",
							description: "This area at the mouth of the San Francisco Bay offers grand views and a variety of birding. Battery
							Godfrey and Lands End west of the Golden Gate Bridge are hotspots where birds can be seen migrating
							north in spring and south in fall. Migration in spring includes swifts, warblers, orioles, and more. Many of
							the same species also pass through again in the fall, but at this time of year look especially for raptors
							crossing the Golden Gate strait from the Marin headlands. Large flocks of Vaux’s Swifts are often seen
							overhead in fall while Elegant Terns are pursued intently by Parasitic Jaegers offshore.",
							short_desc: "This area at the mouth of the San Francisco Bay offers grand views and a variety of birding. Battery
							Godfrey and Lands End west of the Golden Gate Bridge are hotspots where birds can be seen migrating
							north in spring and south in fall.",
							websiteURL: "https://www.presidio.gov/",
							picURL: "https://www.parksconservancy.org/sites/default/files/styles/hero/public/hero/PRSF_180404_ATB_172_Hero.jpg?itok=kYyrELSq&timestamp=1541438945",
 							latitude: "37.800337", longitude: "-122.468419"},

							{name: "Lake Merritt", description: "This lake in Oakland was originally a salt marsh named “Laguna Peralta,” and then became the first
							National Wildlife Refuge in North America in 1869. The lake is a popular wintering site for a great variety
							of waterfowl. A few Barrow’s Goldeneyes spend the winter here and the larger diving ducks such as
							Canvasback, Lesser Scaup, and Greater Scaup are unusually approachable at the shoreline.",
							short_desc: "This lake in Oakland was originally a salt marsh named “Laguna Peralta,” and then became the first
							National Wildlife Refuge in North America in 1869.",
							websiteURL: "https://www.lakemerritt.org/",
							picURL: "https://res.cloudinary.com/simpleview/image/upload/v1511807154/clients/oakland-redesign/neighborhood_lakemerritt_1_61794709-9bfd-4bed-9117-e17ef222bd92.jpg",
 							latitude:"37.803523", longitude:"-122.257413"},

 							{name: "Palo Alto Baylands",
 							description: "The Palo Alto Baylands and vicinity form an extensive complex of wetlands and uplands that has
 							excellent birding opportunities throughout the year. Sora and Virginia’s Rails can be heard calling from the fresh and
 							brackish marshes, while Ridgway’s Rails clamor in the salt marshes along the bay edge. The boardwalk around the Lucy
 							Evans Nature Center is one of the best places to see the latter species as they strut through the exposed marsh
 							channels. Black Rails are also occasionally seen here during king tides in winter. Northern Harriers patrol the
 							marshes and uplands at Bixby Park during the day, and sometimes Short-eared Owls emerge at dusk from the adjacent
 							Palo Alto Flood Control Basin in winter. A great diversity and abundance of waterbirds can be seen on the salt ponds
 							at all times of the year. The baylands are home to a small breeding population of Black Skimmers and a Barrow’s
 							Goldeneye sometimes spends the winter at Shoreline Lake. The melodious song heard around the Rengstorff House in spring
 							and summer comes from a nesting pair of Bullock’s Orioles",
 							short_desc: "The Palo Alto Baylands and vicinity form an extensive complex of wetlands and uplands that has
 							excellent birding opportunities throughout the year. Sora and Virginia’s Rails can be heard calling from the fresh and
 							brackish marshes, while Ridgway’s Rails clamor in the salt marshes along the bay edge.",
 							websiteURL: "https://www.cityofpaloalto.org/gov/depts/csd/parks/preserves/baylands.asp",
 							picURL: "https://i.pinimg.com/originals/3e/1b/58/3e1b5889e8764228ed83c94637b7dae8.jpg",
 							latitude: "37.459905", longitude: "-122.104176"},

 							{name: "Alviso",
 							description: "Several hotspots at the southern end of the bay include parts of Don Edwards San Francisco Bay National
 							Wildlife Refuge, Alviso Marina County Park, and nearby grasslands. At Don Edwards, decommissioned salt ponds provide
 							expansive habitat for many waterbirds. Wintering ducks, shorebirds, and gulls flock to salt pond A16 especially, where
 							nearly 200 species have been found. The islands in this pond provide an excellent study of gulls in the winter, and
 							nesting Caspian and Forster’s Terns in the summer. All three teal species plus Common Gallinule can be seen in nearby
 							Mallard Slough. Just inland from here, Burrowing Owls are sometimes spotted on dirt mounds in the grassland viewable
 							from Disk Drive. At Alviso Marina, the boardwalk crossing the small brackish marsh is a reliable location for Black
 							Rails, which are most vociferous in the summer. In fall and winter, the levees around this marsh host large flocks of
 							sparrows. In spring and fall, tens of thousands of shorebirds gather at the ponds near the marina, and when flushed they
 							swirl around in mesmerizing clouds. The many stellar rarities that have been found here over the years include Little
 							Stint, Bar-tailed Godwit, Curlew Sandpiper, Chimney Swift, and even Greater Roadrunner!",
 							short_desc: "Several hotspots at the southern end of the bay include parts of Don Edwards San Francisco Bay National
 							Wildlife Refuge, Alviso Marina County Park, and nearby grasslands.",
 							websiteURL: "https://www.sccgov.org/sites/parks/parkfinder/Pages/AlvisoMarina.aspx",
 							picURL: "http://sfbaywatertrail.org/wp-content/uploads/2022/04/Alviso_Botkin_040815-21-1920x0-cropped.jpg",
 							latitude: "37.430259", longitude: "-121.979093"},

 							{name: "Ravenswood Salt Pond SF2",
 							description: "The unusual topography of salt pond SF2 is the result of an ambitious restoration experiment by the South
 							Bay Salt Pond Restoration Project. Initiated in 2008, thirty islands of varying shapes were created in the former salt
 							pond to determine habitat preferences of nesting waterbirds. The experiment was a success, as today the pond supports nesting
 							American Avocets, Caspian and Forster’s Terns, and Black Skimmers. Another attraction here are the shorebird flocks, which can
 							number in the tens of thousands at the peak of their migration in April. ",
 							short_desc: "he unusual topography of salt pond SF2 is the result of an ambitious restoration experiment by the South
 							Bay Salt Pond Restoration Project.",
 							websiteURL: "https://www.southbayrestoration.org/locations/ravenswood-sf2-trail",
 							picURL: "https://www.southbayrestoration.org/sites/default/files/styles/max_1300x1300/public/2019-06/01-794A%20Judy%20Irving%20Pelican%20Media.jpg?itok=WOFOFAst",
 							latitude: "37.481333", longitude: "-122.125304"},

 							{name: "Coyote Hills Regional Park",
 							description: "The Coyote Hills are unique as the only naturally formed hills at the edge of the south bay. Interesting flora
 							and geology adorning the hills are best enjoyed in early spring when the wildflowers are blooming. The park is home to most of
 							the same birds found at other areas in the bay, but the oak woodland and tall grassland hills here offer something different.
 							Rock Wrens spend the winter on the rocky outcrops protruding from the grassland slopes, while California Quails form coveys in
 							the oak woodland below. The marshes have a growing population of Great-tailed Grackles and often an American Bittern. ",
 							short_desc: "The Coyote Hills are unique as the only naturally formed hills at the edge of the south bay. Interesting flora
 							and geology adorning the hills are best enjoyed in early spring when the wildflowers are blooming.",
 							websiteURL: "https://www.ebparks.org/parks/coyote_hills/",
 							picURL: "https://kathrynwarmstrong.files.wordpress.com/2016/03/tom-turkey-at-coyote-hills-regional-park-2.jpg",
 							latitude: "37.55680709085135", longitude: "-122.09410271751118"},

 							{name: "Hayward Regional Shoreline",
 							description: "The extensive network of trails around retired salt ponds at this park provides ample opportunity to explore the
 							bay near Hayward. The mosaic of uplands, sloughs, and marshes is a paradise for Northern Harriers in the daytime, and hunting
 							grounds at night for a few Short-eared Owls that spend the winter here. The center of the park—called Mt. Trashmore by locals—is
 							a grassy plateau that attracts flocks of American Pipits and sometimes longspurs in the fall. A breeding colony of Least
 							Terns can be seen on a short walk from the interpretive center at the southern end of the park. This endearing species is one
 							of the rarest breeding birds in the bay. In the summer they are a delight to watch at the colony as they return from the bay and
 							deliver fish to their mate or young.  ",
 							short_desc: "The extensive network of trails around retired salt ponds at this park provides ample opportunity to explore the
 							bay near Hayward.",
 							websiteURL: "https://www.ebparks.org/parks/hayward/",
 							picURL: "https://cdn-assets.alltrails.com/uploads/photo/image/24602749/large_26862332d3d851a36045d42271e50568.jpg",
 							latitude: "37.649128", longitude: "-122.144570"},

 							{name: "Point Pinole Regional Shoreline",
 							description: "Point Pinole is an expansive peninsula protruding into San Pablo Bay.
							 The peninsula is covered in a patchwork of eucalyptus forest and grassland. At the edge of the peninsula the grassland gently
							 slopes into the salt marshes forming a rare natural transition between these two habitats. The eucalyptus forest is inhabited by
							 breeding Purple Finches and Bullock's Orioles in spring and summer, and many Yellow-rumped Warblers in the winter.
							 A nest box project at this park has greatly enhanced the grassland habitat for cavity nesters such as Western Bluebird, House Wren, and Tree Swallow.
							 In summer the swarms of Tree Swallows flying low over the grassland can be dizzying.",
 							short_desc: "Point Pinole is an expansive peninsula protruding into San Pablo Bay.",
 							websiteURL: "https://www.ebparks.org/parks/pt_pinole/",
 							picURL: "https://upload.wikimedia.org/wikipedia/commons/d/de/TamFromPinole.jpg",
 							latitude: "37.99223343", longitude: "-122.356032"},

							{name: "John F. Kennedy Park",
 							description: "While some distance from the bay, this park maintains a connection via the Napa River which feeds into the bay’s extensive sloughs
							 and marshes further downstream. Much of the park is developed but along the western perimeter is a segment of the Bay Trail
							 following the Napa River for nearly two miles. The trail is at the same level of the river so waterfowl are easily viewed here
							 in fall and winter. An alameda of small oaks and cottonwoods line the trail and can have warblers and Oak Titmouses.
							 When the deciduous trees along this trail lose their foliage in winter, old bird nests may be revealed. Look for the hanging nest
							 of a Bushtit or the open stick nest of a Northern Mockingbird used in breeding seasons past. A duck
							 pond on the entrance road is worth checking for interesting waterfowl that sometimes drop in.",
							 short_desc: "While some distance from the bay, this park maintains a connection via the Napa River which feeds into the bay’s extensive sloughs
							 and marshes further downstream.",
 							websiteURL: "https://www.cityofnapa.org/Facilities/Facility/Details/Kennedy-Park-28",
 							picURL: "https://assets.simpleviewinc.com/simpleview/image/upload/crm/napavalley/448_8915145d-5056-a36a-0852c8376146fe7f.jpg",
 							latitude: "38.2655389", longitude: "-122.2827163"},

							{name: "Shollenberger Park",
 							description: "Shollenberger Park is an example of how wetlands benefit both wildlife and the citizens that live nearby. The park is a complex series of seasonal wetlands that provide high quality habitat for wildlife while serving as flood protection to nearby neighborhoods. 
							 Willows and elderberries in the uplands of the park attract many birds throughout the year, and the mudflats in the wetlands are always busy with various waterbirds, especially in spring and fall
							 when the lower water level is favorable to shorebirds. Look for Common Gallinules hugging the shoreline of the wetlands and an occasional Pacific Golden-Plover on the mudflat in fall.",
							 short_desc: "Shollenberger Park is a complex series of seasonal wetlands that provide high quality habitat for wildlife while serving as flood protection to nearby neighborhoods. ",
 							websiteURL: "https://www.sonomacounty.com/outdoor-activities/shollenberger-park",
 							picURL: "https://www.sonomacounty.com/sites/default/files/styles/profile_photo_full/public/listing_images/profile/1779/shollenberger-120_90275453-5056-a36a-077580718e3fd23e.jpg?itok=ExInqnOp",
 							latitude: "38.226216328", longitude: "-122.5986369"},

							{name: "Las Gallinas Sanitary District Wildlife Area",
							description:"Next to a waste water treatment plant, this site has a rich
							diversity of ducks, herons and egrets, shorebirds, swallows, and
							other wetland denizens. A
							levee trail leading from the
							parking area circles around
							several large ponds. The
							first pond along the trail is
							maintained as a wetland
							and has bulrushes, willows,
							and other vegetation busy
							with nesting Marsh Wrens
							and Common Yellowthroats. The many species at this pond now
							include Least Bittern, a recent addition to the breeding avifauna in this area. Listen for their understated coo-coo-coo call
							emanating from the wetland vegetation during the summer. The
							ponds further from the parking area are kept mostly denuded but
							they are still productive for waterfowl; look for Common Merganser and Common Goldeneye on these ponds. Tree and Cliff
							Swallows can be especially abundant at the ponds and surrounding open space in spring and summer.",
							short_desc:"Las Gallinas Sanitary District Wildlife Area has a rich
							diversity of ducks, herons and egrets, shorebirds, swallows, and
							other wetland denizens.",
						 	websiteURL:"http://www.lgvsd.org/community-programs/public-access/wildlife-info/",
							picURL:"https://www.marinmommies.com/sites/default/files/stories/lasgallinas3_0.jpg",
							latitude:"38.02554219468899",
						 	longitude: "-122.5189191315",
							},

							{name: "China Camp State Park",
							description:"China Camp State Park is a convenient, scenic getaway from the
							Bay Area metropolis. Salt marsh abuts hills covered in oak woodland creating an interesting juxtaposition of habitats
							found nowhere else in the
							bay. North San Pedro Road
							winds along the perimeter of
							the salt marsh and is suitable
							for leisurely birding. From
							this road, White-tailed Kites
							and Northern Harriers can be
							seen hunting for prey hiding
							in the marsh. The many trails
							leading into the hills above the marsh provide opportunities to
							see various landbirds such as Spotted Towhees and Wrentits.",
							short_desc:"China Camp State Park is a convenient, scenic getaway from the
							Bay Area metropolis.",
						 	websiteURL:"http://www.parks.ca.gov/?page_id=466",
							picURL:"http://www.parks.ca.gov/pages/466/images/img_9031lowres.jpg",
							latitude:"38.00135443117158",
						 	longitude: "-122.491010329139",
							},
							{name: "Corte Madera Marsh Ecological Reserve",
							description:"As with many places in bay, there is an abrupt transition from the
							urban sprawl to the marshes of Corte Madera Marsh Ecological
							Reserve. Once inside the park it is a
							peaceful place where the sound of
							clamoring Ridgway’s Rails and buzzing
							Song Sparrows are principals of the
							soundscape. There is a bicycle path
							around the uplands and single-track
							trails further to the north and south
							that are worth exploring. Some of the
							trails are small rises above the marsh
							allowing a unique, close-up view
							of this habitat.",
							short_desc:"As with many places in bay, there is an abrupt transition from the
							urban sprawl to the marshes of Corte Madera Marsh Ecological
							Reserve.",
						 	websiteURL:"https://wildlife.ca.gov/Lands/Places-to-Visit/Corte-Madera-Marsh-ER",
							picURL:"https://www.marinij.com/wp-content/uploads/2021/01/MIJ-L-CMADMARSH-0130-08.jpg?w=1024&h=768",
							latitude:"37.93605276770284",
						 	longitude: "-122.51407611328601",
							},
							{name: "Benicia State Recreation Area",
							description:"Tucked into a small bay on the Carquinez Strait, this park has
							impressive views of the strait and the grassy foothills rising
							above it. The salt marsh here
							is untouched and is home to
							most of the marsh birds found
							elsewhere in the bay. The fruiting
							trees in the small native botanic
							garden attract many birds during
							migration and winter. The hillside
							above the garden is part of Dillon
							Point, which is a nice place
							to spend an afternoon watching for raptors catching thermals
							overhead. The klaxon alarm of a Ring-necked Pheasant may be
							heard from the patches of sedges nearby.",
							short_desc:"Tucked into a small bay on the Carquinez Strait, this park has
							impressive views of the strait and the grassy foothills rising
							above it.",
						 	websiteURL:"https://www.parks.ca.gov/?page_id=476",
							picURL:"https://www.parks.ca.gov/pages/476/images/BeniciaSRA-Palmer_P059932.jpg",
							latitude:"38.073499265327285",
						 	longitude: "-122.19262354236336",
							},
							{name: "Hudeman Slough",
							description:"Hudeman Slough is one of many waterways through the expansive landscape of grain fields, vineyards, and wetlands in
							this area. The quiet levee trails at this park have panoramic
							views that include Mount Diablo, Mount Tamalpais, and the
							Napa-Sonoma wine country. Waterfowl and shorebirds are
							attracted to the area in great diversity, especially in spring and
							fall when birding is best. Cinnamon Teal breed in the marsh and
							an occasional Swainson’s Hawk may be seen soaring overhead.",
							short_desc:"Hudeman Slough is one of many waterways through the expansive landscape of grain fields, vineyards, and wetlands in
							this area.",
						 	websiteURL:"https://www.sonomahikingtrails.com/parks/hudeman-slough-wetlands/",
							picURL:"https://photos.alltrails.com/eyJidWNrZXQiOiJhc3NldHMuYWxsdHJhaWxzLmNvbSIsImtleSI6InVwbG9hZHMvcGhvdG8vaW1hZ2UvMzI5OTQ5OTQvNmFhOWM3NjZiM2M1YzMxMjFjNzAxZDMzMmNkYjgyYWEuanBnIiwiZWRpdHMiOnsidG9Gb3JtYXQiOiJqcGVnIiwicmVzaXplIjp7IndpZHRoIjo1MDAsImhlaWdodCI6NTAwLCJmaXQiOiJpbnNpZGUifSwicm90YXRlIjpudWxsLCJqcGVnIjp7InRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pc2VTY2FucyI6dHJ1ZSwicXVhbnRpc2F0aW9uVGFibGUiOjN9fX0=",
							latitude:"38.20574612502795",
						 	longitude: "-122.37440231578378",
							}
 						]);



















