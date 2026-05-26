import pandas as pd
import io

# Definitive list of 140 Paletará producers provided by the user
paletara_text = """
34554040	Maria de Lourdes Mensa Cerquera	El Jigual 2	Puracé
10544540	Atanasio Garcia Perez	El Jigual 2	Puracé
76290507	Guillermo Humberto Moncada Menza	El Jigual 2	Puracé
10106323	Alirio Sanchez Muñoz	El Jigual 2	Puracé
76320685	Carlos Adelmo Silva Atehortua	El Jigual 2	Puracé
34330581	Rosalba Andrea Astaiza Bolaños	El Jigual 2	Puracé
34523881	Irma Ines Astaiza	El Jigual 2	Puracé
1060238864	Anuar Adrian Astaiza Muñoz	El Jigual 2	Puracé
25627858	Gabi Stella Collazos Astaiza	El Jigual 2	Puracé
10575136	Jose Andres Narvaez Guañarita	El Jigual 2	Puracé
25628735	Sandra Patricia Astaiza Hernandez	El Jigual 2	Puracé
25627862	Armida Ordoñez Narváez	El Jigual 2	Puracé
25628171	Yeim Sofia Vargas Gutierres	El Jigual 2	Puracé
25628696	Carmen Delia Coque Urrea	El Jigual 2	Puracé
76306436	Felipe Muñoz Astaiza	El Jigual 2	Puracé
1061716801	Duban Ernesto Collazos	El Jigual 2	Puracé
10575065	Ismael Antonio Cuaji	El Jigual 2	Puracé
1002876437	Miller Fernando Muñoz Pardo	Mirador	Puracé
10291996	Elias Bolaños Mosquera	Mirador	Puracé
76314811	Ruben Dario Chilito Astaiza	Mirador	Puracé
25628454	Yudy Paola Coque Astaiza	Mirador	Puracé
1061707699	Wildeman Mauricio Coque Chilito	Mirador	Puracé
1061735931	Alexander Tintinago Fernández	Mirador	Puracé
76276263	Carlos Albeiro Orozco Bahos	Mirador	Puracé
1060237379	Marisol Coque Hoyos	Mirador	Puracé
10575078	Luis Carlos Astaiza	Mirador	Puracé
34536875	Luz Eddy Mosquera Diaz	Mirador	Puracé
76290446	Jaime Humberto Hoyos Ocoro	Mirador	Puracé
76317893	Alirio Tombe Hoyos	Mirador	Puracé
4788051	Oscar Armando Quilindo Camayo	Mirador	Puracé
34324603	Yina Cecilia Pillimur Benavides	Mirador	Puracé
34536354	Suli del Carmen Ruiz	Mirador	Puracé
25628736	Maria Cristina Astaiza Hernández	Mirador	Puracé
1060236659	Jadyr Astaiza Coque	Mirador	Puracé
34557594	Ximena Sotelo	Piedra de león	Puracé
10575132	Ever Omar Zambrano Muñoz	Piedra de león	Sotará
10575125	Hector Willard Chalapu Muñoz	Piedra de león	Sotará
76327892	Ramiro Castillo Mosca	Piedra de león	Puracé
10575117	Jose Gerardo Anacona Yace	Piedra de león	Sotará
25628222	Sandra Lorena Chalapu Muñoz	Piedra de león	Sotará
34543804	Maria Carlina Chilito Astaiza	Piedra de león	Sotará
1060236279	Ana Ruth Avirama Meneses	Piedra de león	Sotará
25628392	Mariela Coque	Piedra de león	Sotará
1061763987	Maicol Eduart Mueses Yace	Piedra de león	Sotará
76327826	Eider Arnulfo Zambrano Chilito	Piedra de león	Sotará
76321243	Alfonso Ordoñez Salazar	Piedra de león	Sotará
76328222	Jorge Enrique Charo Peteche	Josefina	Puracé
1061730721	Nery Viviana Sanchez Coaji	Josefina	Puracé
1061703828	Paola Andrea Sánchez Serna	Josefina	Puracé
10538012	Jose Roberto Gutierrez Sanchez	Josefina	Puracé
1060238812	Duber Alveiro Vasquez Chilito	Josefina	Puracé
10575063	Laurentino Sanchez Sanchez	Josefina	Puracé
34563358	Gloria Stella Bolaños Yace	Josefina	Puracé
25628034	Yeni Amparo Bolaños Muñoz	Josefina	Puracé
10541232	Marino Narvaez Muñoz	Josefina	Puracé
25682684	Alba Ceneida Fernández Solarte	Josefina	Puracé
76290101	Jose Gerardo Levaza Gurrute	Josefina	Puracé
25276463	Blanca Nelli Ydrobo Santiago	Josefina	Puracé
76325946	Jose Guillermo Chapues Caso	Josefina	Puracé
10535219	Carlos Alberto Narvaez Muñoz	Josefina	Puracé
10575121	Lucio Mapallo Melenge	Josefina	Puracé
5253954	Jose Miguel Termal Malte	Josefina	Puracé
10532555	Marco Aurelio Granados Herrera	Josefina	Puracé
1002876646	Blanca Magnolia Hormiga Chapues	Josefina	Puracé
76290044	Ruben Dario Basto	Josefina	Puracé
1060238630	Juan Pablo Termal Tutalcha	Josefina	Puracé
76303647	Magliony Narvaez Muñoz	Josefina	Puracé
1060239261	Dany Bibiana Hormiga Chapues	Josefina	Puracé
34330598	Sixta Tulia Chapues Caso	Josefina	Puracé
10297398	Jesus Alfonso Chapues Caso	Josefina	Puracé
76290307	Ramiro Narvaez Mapallo	Josefina	Puracé
76290538	Eyver Alfredo Melenje	Josefina	Puracé
1060237679	Ferney Alexander Yalanda Pausa	Rio Negro	Puracé
10290482	Jander Andres Perdomo Yace	Rio Negro	Puracé
10290328	Lorenzo Tombe Yace	Rio Negro	Puracé
25628686	Ana Teresa Camayo Chaparral	Rio Negro	Puracé
25284669	Yaned Patricia Camayo	Rio Negro	Puracé
1061723670	Edwin Ivan Idrobo Santiago	Rio Negro	Puracé
1060237237	Melba Magnolia Avirama Olave	Rio Negro	Puracé
10575100	Jesús María Tombe Yace	Rio Negro	Puracé
34532677	Maria Cruz Sánchez de Conejo	Rio Negro	Puracé
10575092	Marino Tombe Yace	Rio Negro	Puracé
4611925	Wilfredo Guauña Niquinas	Rio Negro	Puracé
76310062	Benjamin Meneses Paredes	Rio Negro	Puracé
25628727	Maria Delia Magon Gurrute	Rio Negro	Puracé
1061724409	Dinael Francisco Velasco Camayo	Rio Negro	Puracé
25628220	Ana Cleotilde Camayo Yalanda	Rio Negro	Puracé
10575058	Jose Rafael Gutierrez Sanchez	Rio Negro	Puracé
25628702	Maria Cecilia Tombe Yace	Rio Negro	Puracé
1061803252	Angye Viviana Alonso Chaparral	Rio Negro	Puracé
1061711097	Mariana Velasco Guauña	Rio Negro	Puracé
34550377	Mariela Guauña Cuchumbe	Rio Negro	Puracé
25628152	Miriam Patricia Hidrobo Perdomo	Rio Negro	Puracé
76290325	Jorge Apolinar Mensa Cerquera	El Jigual 2	Puracé
1060238172	Yoher Alexis Quelal Coaji	El Jigual 2	Puracé
1064427718	Carmen Nery Velasco Almendra	Rio Negro	Puracé
25290321	Ismenia Coaji Guadir	Rio Negro	Puracé
76290304	Milton Dario Cerquera Urrutia	Rio Negro	Puracé
76290488	Luis Humberto Morales Perafan	Centro	Puracé
76290685	Omar Adriano Coque	Centro	Puracé
25628709	Maria Rubiela Magon Niquinaz	Centro	Puracé
25628072	Maria Isabel Yalanda Pausa	Centro	Puracé
1060238794	Sandra Mileth Susatama Astaiza	Deposito	Puracé
1060236089	Nilson Jair Muñoz Muñoz	Deposito	Puracé
25628666	Esperanza Rivera Garzón	Deposito	Puracé
1061709854	Jeison Almir Yacumal Coque	Deposito	Puracé
10575076	Jose Rey Cuaji Susatama	Deposito	Puracé
4749246	Juan Bautista Coque Rivera	Deposito	Puracé
1430695	Francisco Arnol Chalapu Muñoz	Deposito	Puracé
1061758574	Hector Ignacio Narvaez Bolaños	Deposito	Puracé
1060236288	Anderson Muñoz Olave	Deposito	Puracé
10535942	Arnulfo Muñoz	Deposito	Puracé
76322728	Rodrigo Golondrino Melenje	Deposito	Puracé
1061744523	Nestor Fabian Conejo Perdomo	Deposito	Puracé
34528698	Maria Doris Perdomo Coque	Deposito	Puracé
1002961956	Juan Camilo Velasco Sandoval	Deposito	Puracé
10526417	Pedro Anibal Cuaji Susatama	Deposito	Puracé
10575126	Macister Muñoz Alonso	Deposito	Puracé
76307746	Jabier Magon Gurrute	Deposito	Puracé
83042886	Fabio Nelson Termal Basto	Deposito	Puracé
25628664	Edelmira Quilindo Astaiza	Deposito	Puracé
10545716	Guido Hernan Meneses	Deposito	Puracé
25706853	Olga Fani Velazco Salazar	Rio Claro	Puracé
25628657	Carmelina Muñoz de Mosca	Rio Claro	Puracé
25628649	Miriam Ester Magin Olave	Rio Claro	Puracé
76307245	Fernando Arturo Olave Mosquera	Rio Claro	Puracé
25628600	Maria Esther Gutierrez de Callapu	Rio Claro	Puracé
10530463	Pedro Leon Perdomo Gutierrez	Rio Claro	Puracé
52222636	Aura Elisa Olave Mosquera	Rio Claro	Puracé
1060237167	Maria Claudia Muñoz Olave	Rio Claro	Puracé
4749488	Jose Cipriano Avirama	Rio Claro	Puracé
25628734	Aura Matilde Muñoz Alonso	Rio Claro	Puracé
34599376	Rosa Elena Yule Guasaquillo	Rio Claro	Puracé
25628697	Gerardina Gurrute	Rio Claro	Puracé
4611633	Helber Olmedo Camayo	Rio Claro	Puracé
76313627	Jose Glenis Serna Bolaños	Rio Claro	Puracé
35511195	Luz Marina Quintero Muñoz	Rio Claro	Puracé
25628714	Rut Deomira Olave Mosquera	Rio Claro	Puracé
25628731	Luz Mila Cuaji Perdomo	Rio Claro	Puracé
34562649	Aida Ligia Olave Mosquera	Rio Claro	Puracé
"""

# Extract cedulas
paletara_cedulas = [line.split('\t')[0].strip() for line in paletara_text.strip().split('\n') if line.strip()]

# Sotará 130 list (from previous turn logic)
sotara_130_cedulas = [
    '4771236', '39623902', '25693683', '29774725', '1005979002', '106476394', '25693546', '31476021', '25694102', '1063810090', '4771164', '25702819', '25691306', '13039313', '25694177', '1061770754', '25693801', '34547634', '4788173', '4771252', '10291060', '1806967', '4774379', '10455131', '4771199', '4771279', '16783793', '52158097', '34329981', '25693804', '25694101', '87217881', '11389333', '76290011', '25693701', '34485089', '4787769', '10545079', '98341686', '55163823', '30688542', '34550554', '10290755', '76309539', '76316673', '4771314', '76295922', '76290042', '25697112', '1064676830', '1061698446', '4771241', '98341876', '1002821603', '4771399', '10308477', '1063817889', '1060237416', '34315870', '76330564', '34562182', '4749497', '76317110', '36381597', '1061704137', '34323133', '39793246', '48600036', '25700280', '34321845', '34543947', '16667705', '4773045', '1064676497', '1061791193', '1064677022', '1081702462', '1517795', '4773064', '4771288', '1061794141', '1063809524', '1063806941', '4773002', '76308041', '4771230', '25290509', '10532886', '1061693094', '26308173', '1517686', '4771187', '10516112', '76314835', '1061713441', '1061706732', '1061686462', '48661807', '25693748', '1061733459', '4771096', '76028835', '25706328', '4771606', '1064676728', '34475112', '25693772', '1064676399', '76030030', '25693713', '4771438', '76296906', '1064676920', '1064676291', '1060238959', '1064677004', '1061746316', '76290202', '51786901', '10542047', '48661808', '98396591', '10548542', '1517789', '76312936', '351677', '76284900', '76306996', '1064676922', '76310162'
]

print(f"Paletara list size: {len(paletara_cedulas)}")
print(f"Sotara list size: {len(sotara_130_cedulas)}")

# Check for overlap
overlap = set(paletara_cedulas).intersection(set(sotara_130_cedulas))
print(f"Overlap size: {len(overlap)}")
if overlap:
    print(f"Overlap cedulas: {overlap}")

# Identify people in DB but not in either list
# I will need to query the DB for this in a separate step.
