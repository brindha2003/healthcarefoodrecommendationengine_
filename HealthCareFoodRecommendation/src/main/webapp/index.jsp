<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.healthCareFoodRecommendation.Model.DiabeticUser" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    // Get user from session
    DiabeticUser user = (DiabeticUser) session.getAttribute("loggedInUser");
    boolean isLoggedIn = (user != null);
    
    // Variables declared only if user is logged in
    double bmi = 0;
    String bmiCategory = "";
    String bmiBadgeClass = "";
    String bloodSugarStatus = "";
    String bloodSugarAlertClass = "";
    String foodRecommendation = "";
    String activityRecommendation = "";
    String mealTiming = "";
    
    // Enhanced Food recommendations database with Indian/Tamilnadu foods
    Map<String, Map<String, List<String>>> foodRecommendations = new HashMap<>();
    
    // Type 1 diabetes recommendations (with carb counts for insulin users)
    Map<String, List<String>> type1Recs = new HashMap<>();
    List<String> type1Veg = new ArrayList<>();
    type1Veg.add("Quinoa Pongal with vegetables (45g carbs) + insulin dose as directed");
    type1Veg.add("Methi (Fenugreek) Roti with dal (35g carbs) + insulin dose as directed");
    type1Veg.add("Bajra (Pearl Millet) Dosa with sambar (40g carbs) + insulin dose as directed");
    type1Veg.add("Vegetable Kootu with brown rice (50g carbs) + insulin dose as directed");
    type1Veg.add("Paneer Bhurji with multigrain roti (30g carbs) + insulin dose as directed");
    type1Veg.add("Ragi (Finger Millet) Idli with coconut chutney (35g carbs) + insulin dose");
    type1Veg.add("Thinai (Foxtail Millet) Upma with vegetables (40g carbs) + insulin dose");
    type1Veg.add("Kambu (Pearl Millet) Adai with avial (45g carbs) + insulin dose");
    type1Veg.add("Samai (Little Millet) Pongal with ghee (40g carbs) + insulin dose");
    type1Veg.add("Varagu (Kodo Millet) Lemon Rice (35g carbs) + insulin dose");
    type1Veg.add("Vegetable Stew with appam (45g carbs) + insulin dose");
    type1Veg.add("Moong Dal Khichdi with curd (40g carbs) + insulin dose");
    type1Veg.add("Vegetable Biryani with raita (50g carbs) + insulin dose");
    type1Veg.add("Pesarattu (Green Gram Dosa) with ginger chutney (30g carbs) + insulin dose");
    type1Veg.add("Oats Idli with sambar (35g carbs) + insulin dose");
    type1Veg.add("Vegetable Pulao with cucumber raita (45g carbs) + insulin dose");
    type1Veg.add("Masala Dosa with coconut chutney (50g carbs) + insulin dose");
    type1Veg.add("Vegetable Kurma with whole wheat roti (40g carbs) + insulin dose");
    type1Veg.add("Soya Chunks Curry with brown rice (45g carbs) + insulin dose");
    type1Veg.add("Sprouts Salad with lemon dressing (25g carbs) + insulin dose");
    type1Veg.add("Vegetable Uttapam with tomato chutney (40g carbs) + insulin dose");
    type1Veg.add("Dal Tadka with jowar roti (35g carbs) + insulin dose");
    type1Veg.add("Vegetable Khichdi with papad (40g carbs) + insulin dose");
    type1Veg.add("Avial with small portion of red rice (45g carbs) + insulin dose");
    type1Veg.add("Keerai (Spinach) Kootu with millet roti (30g carbs) + insulin dose");
    type1Veg.add("Mixed Vegetable Sambar with quinoa (40g carbs) + insulin dose");
    type1Veg.add("Vegetable Pongal with sambar (45g carbs) + insulin dose");
    type1Veg.add("Paneer Tikka with multigrain roti (35g carbs) + insulin dose");
    type1Veg.add("Vegetable Stir Fry with brown rice (40g carbs) + insulin dose");
    type1Veg.add("Dal Makhani with bajra roti (35g carbs) + insulin dose");
 // Breakfast Items
    type1Veg.add("Kambu (Pearl Millet) Koozh with buttermilk (35g carbs) + insulin dose");
    type1Veg.add("Ragi Kali with keerai poriyal (30g carbs) + insulin dose");
    type1Veg.add("Thinai (Foxtail Millet) Pongal with sambar (40g carbs) + insulin dose");
    type1Veg.add("Kuthiraivali (Barnyard Millet) Upma with mint chutney (35g carbs) + insulin dose");
    type1Veg.add("Varagu (Kodo Millet) Idiyappam with vegetable kurma (45g carbs) + insulin dose");

    // Rice Dishes
    type1Veg.add("Mappillai Samba Rice with paruppu rasam (40g carbs) + insulin dose");
    type1Veg.add("Karuppu Kavuni (Black Rice) with mor kuzhambu (35g carbs) + insulin dose");
    type1Veg.add("Thooyamalli Rice with vendakkai curry (40g carbs) + insulin dose");
    type1Veg.add("Poongul Arisi (Red Rice) with kathrikai gotsu (45g carbs) + insulin dose");
    type1Veg.add("Samba Wheat Kanji with ulli theeyal (30g carbs) + insulin dose");

    // Tiffin Items
    type1Veg.add("Kambu Dosa with nattu sakkarai podi (35g carbs) + insulin dose");
    type1Veg.add("Kuthiraivali Adai with avial (40g carbs) + insulin dose");
    type1Veg.add("Ragi Roti with kollu kuzhambu (30g carbs) + insulin dose");
    type1Veg.add("Samai (Little Millet) Puttu with kadala curry (45g carbs) + insulin dose");
    type1Veg.add("Kuzhi Paniyaram with coconut chutney (40g carbs) + insulin dose");

    // Traditional Specials
    type1Veg.add("Keerai Masiyal with small portion of kambu sadam (35g carbs) + insulin dose");
    type1Veg.add("Pulikkuzhambu with thinai rice (40g carbs) + insulin dose");
    type1Veg.add("Arachuvitta Sambar with varagu arisi (45g carbs) + insulin dose");
    type1Veg.add("Kothavarangai Paruppu Usili with millet rice (30g carbs) + insulin dose");
    type1Veg.add("Murungakkai Podi Curry with jowar roti (35g carbs) + insulin dose");

    // Light Meals
    type1Veg.add("Koozh Vadai (made with kambu flour) with green chutney (30g carbs) + insulin dose");
    type1Veg.add("Pasi Paruppu Kanji with garlic roast (25g carbs) + insulin dose");
    type1Veg.add("Mochai Kottai Sundal (25g carbs) + insulin dose");
    type1Veg.add("Kambu Soup with vegetables (20g carbs) + insulin dose");
    type1Veg.add("Sathukudi (Sweet Lime) and Groundnut Salad (15g carbs) + insulin dose");

    // Dinner Options
    type1Veg.add("Kollu Rasam with small portion of millet rice (35g carbs) + insulin dose");
    type1Veg.add("Vendakkai Morekozhambu with thinai rice (40g carbs) + insulin dose");
    type1Veg.add("Poondu Kuzhambu with kambu roti (35g carbs) + insulin dose");
    type1Veg.add("Paruppu Podi with gingelly oil + small portion of red rice (30g carbs) + insulin dose");
    type1Veg.add("Kathrikai Gothsu with ragi dosa (40g carbs) + insulin dose");

       type1Recs.put("Veg", type1Veg);

 
    
    List<String> type1NonVeg = new ArrayList<>();
    type1NonVeg.add("Grilled fish with millet rice (30g carbs) + insulin dose as directed");
    type1NonVeg.add("Chicken Chettinad with small portion of rice (40g carbs) + insulin dose");
    type1NonVeg.add("Egg curry with whole wheat roti (35g carbs) + insulin dose as directed");
    type1NonVeg.add("Fish curry with quinoa (30g carbs) + insulin dose as directed");
    type1NonVeg.add("Mutton sukka with ragi roti (25g carbs) + insulin dose as directed");
    type1NonVeg.add("Nethili (Anchovy) Fish Fry with millet rice (30g carbs) + insulin dose");
    type1NonVeg.add("Chicken Biryani with raita (50g carbs) + insulin dose");
    type1NonVeg.add("Egg Bhurji with multigrain roti (30g carbs) + insulin dose");
    type1NonVeg.add("Fish Molee with appam (45g carbs) + insulin dose");
    type1NonVeg.add("Prawn Curry with brown rice (40g carbs) + insulin dose");
    type1NonVeg.add("Chicken Stew with whole wheat bread (35g carbs) + insulin dose");
    type1NonVeg.add("Mutton Curry with bajra roti (30g carbs) + insulin dose");
    type1NonVeg.add("Egg Roast with dosa (40g carbs) + insulin dose");
    type1NonVeg.add("Fish Puttu with coconut milk (35g carbs) + insulin dose");
    type1NonVeg.add("Chicken 65 with small portion of rice (40g carbs) + insulin dose");
    type1NonVeg.add("Crab Masala with quinoa (30g carbs) + insulin dose");
    type1NonVeg.add("Egg Fried Rice with vegetables (45g carbs) + insulin dose");
    type1NonVeg.add("Chicken Tikka with roti (35g carbs) + insulin dose");
    type1NonVeg.add("Fish Biryani with raita (50g carbs) + insulin dose");
    type1NonVeg.add("Prawn Masala with millet dosa (40g carbs) + insulin dose");
    type1NonVeg.add("Mutton Biryani with onion raita (55g carbs) + insulin dose");
    type1NonVeg.add("Chicken Curry with appam (45g carbs) + insulin dose");
    type1NonVeg.add("Egg Dosa with chutney (40g carbs) + insulin dose");
    type1NonVeg.add("Fish Cutlet with salad (30g carbs) + insulin dose");
    type1NonVeg.add("Chicken Sukka with ragi roti (35g carbs) + insulin dose");
    type1NonVeg.add("Prawn Fry with quinoa upma (40g carbs) + insulin dose");
    type1NonVeg.add("Mutton Keema with whole wheat paratha (45g carbs) + insulin dose");
    type1NonVeg.add("Chicken Roast with small portion of rice (40g carbs) + insulin dose");
    type1NonVeg.add("Egg Curry with millet dosa (35g carbs) + insulin dose");
    type1NonVeg.add("Fish Tikka with salad (25g carbs) + insulin dose");
    type1NonVeg.add("Meen Kuzhambu (Fish Curry) with small portion of kambu rice (35g carbs) + insulin dose");
    type1NonVeg.add("Nethili (Anchovy) Fry with millet kanji (25g carbs) + insulin dose");
    type1NonVeg.add("Karaikudi Chicken Chettinad with varagu rice (40g carbs) + insulin dose");
    type1NonVeg.add("Mutton Chukka with ragi roti (30g carbs) + insulin dose");
    type1NonVeg.add("Koonthal (Squid) Roast with thinai upma (35g carbs) + insulin dose");
    type1NonVeg.add("Ayirai Meen (Catfish) Puli Curry with small rice portion (30g carbs) + insulin dose");
    type1NonVeg.add("Kadalal (Mussels) Moilee with appam (45g carbs) + insulin dose");
    type1NonVeg.add("Naatu Kozhi (Country Chicken) Rasam with millet rice (30g carbs) + insulin dose");
    type1NonVeg.add("Eral (Prawn) Thokku with jowar roti (35g carbs) + insulin dose");
    type1NonVeg.add("Kaadai (Quail) Fry with kuthiraivali sadam (30g carbs) + insulin dose");
    type1NonVeg.add("Meen (Fish) Biryani with raita (50g carbs) + insulin dose");
    type1NonVeg.add("Kozhi (Chicken) Milagu Varuval with bajra roti (35g carbs) + insulin dose");
    type1NonVeg.add("Aatu Kari (Mutton) Kola Urundai with millet soup (30g carbs) + insulin dose");
    type1NonVeg.add("Sura Puttu (Shark Fin) Curry with small rice (40g carbs) + insulin dose");
    type1NonVeg.add("Naatu Kozhi (Country Chicken) Sukka with ragi dosa (35g carbs) + insulin dose");
    type1NonVeg.add("Kanava (Cuttlefish) Varuval with quinoa (30g carbs) + insulin dose");
    type1NonVeg.add("Kadal (Mussel) Curry with kambu koozh (35g carbs) + insulin dose");
    type1NonVeg.add("Kozhi (Chicken) Nirachaathu with appam (45g carbs) + insulin dose");
    type1NonVeg.add("Eral (Prawn) Podi Curry with samai rice (40g carbs) + insulin dose");
    type1NonVeg.add("Meen (Fish) Mappas with whole wheat appam (40g carbs) + insulin dose");
    type1NonVeg.add("Naatu Kozhi (Country Chicken) Kuzhambu with millet rice (35g carbs) + insulin dose");
    type1NonVeg.add("Kaalaa (Crab) Masala with thinai roti (30g carbs) + insulin dose");
    type1NonVeg.add("Kozhi (Chicken) 65 with small portion rice (40g carbs) + insulin dose");
    type1NonVeg.add("Aatu Kari (Mutton) Chukka with ragi mudde (25g carbs) + insulin dose");
    type1NonVeg.add("Nandu (Crab) Rasam with quinoa (30g carbs) + insulin dose");
    type1NonVeg.add("Kozhi (Chicken) Varuval with kambu dosa (35g carbs) + insulin dose");
    type1NonVeg.add("Eral (Prawn) Roast with small portion rice (40g carbs) + insulin dose");
    type1NonVeg.add("Meen (Fish) Cutlet with salad (25g carbs) + insulin dose");
    type1NonVeg.add("Naatu Kozhi (Country Chicken) Biryani with onion raita (50g carbs) + insulin dose");
    type1NonVeg.add("Kaadai (Quail) Peralan with millet rice (35g carbs) + insulin dose");
    type1NonVeg.add("Koonthal (Squid) Chukka with bajra roti (30g carbs) + insulin dose");
    type1NonVeg.add("Kozhi (Chicken) Korma with whole wheat appam (45g carbs) + insulin dose");
    type1NonVeg.add("Aatu Kari (Mutton) Biryani with cucumber raita (55g carbs) + insulin dose");
    type1NonVeg.add("Meen (Fish) Molee with small portion rice (40g carbs) + insulin dose");
    type1NonVeg.add("Eral (Prawn) Kuzhambu with samai rice (40g carbs) + insulin dose");
    type1NonVeg.add("Kozhi (Chicken) Varutharachathu with ragi dosa (35g carbs) + insulin dose");
    type1NonVeg.add("Nandu (Crab) Varuval with kuthiraivali rice (30g carbs) + insulin dose");
    type1NonVeg.add("Kaalaa (Crab) Curry with small appam (45g carbs) + insulin dose");
    type1NonVeg.add("Naatu Kozhi (Country Chicken) Kurma with millet roti (35g carbs) + insulin dose");
    type1NonVeg.add("Meen (Fish) Puttu with coconut milk (35g carbs) + insulin dose");
    type1NonVeg.add("Kozhi (Chicken) Chettinad with varagu rice (40g carbs) + insulin dose");
    type1NonVeg.add("Aatu Kari (Mutton) Kheema with whole wheat parotta (45g carbs) + insulin dose");
    type1NonVeg.add("Eral (Prawn) Roast with quinoa (30g carbs) + insulin dose");
    type1NonVeg.add("Koonthal (Squid) Masala with thinai dosa (35g carbs) + insulin dose");
    type1NonVeg.add("Meen (Fish) Varuval with keerai rice (30g carbs) + insulin dose");
    type1NonVeg.add("Kozhi (Chicken) Pepper Fry with small portion rice (40g carbs) + insulin dose");
    type1NonVeg.add("Naatu Kozhi (Country Chicken) Soup with millet bread (25g carbs) + insulin dose");
    type1NonVeg.add("Kaadai (Quail) Roast with ragi roti (30g carbs) + insulin dose");
    type1NonVeg.add("Nandu (Crab) Peralan with kambu rice (35g carbs) + insulin dose");
    type1NonVeg.add("Meen (Fish) Curry with small appam (45g carbs) + insulin dose");
    type1Recs.put("Non-Veg", type1NonVeg);
    foodRecommendations.put("Type 1", type1Recs);
    
    // Type 2 diabetes recommendations (low glycemic index)
    Map<String, List<String>> type2Recs = new HashMap<>();
    List<String> type2Veg = new ArrayList<>();
    type2Veg.add("Kambu (Pearl Millet) Koozh with buttermilk");
    type2Veg.add("Avial with small portion of brown rice");
    type2Veg.add("Keerai (Spinach) Kootu with millet roti");
    type2Veg.add("Sundal (Steamed Legumes) salad");
    type2Veg.add("Vegetable Sambar with ragi dosa");
    type2Veg.add("Thinai (Foxtail Millet) Pongal with vegetables");
    type2Veg.add("Ragi (Finger Millet) Mudde with sambar");
    type2Veg.add("Samai (Little Millet) Upma with vegetables");
    type2Veg.add("Varagu (Kodo Millet) Pulao with raita");
    type2Veg.add("Kuthiraivali (Barnyard Millet) Khichdi");
    type2Veg.add("Paneer Tikka with salad");
    type2Veg.add("Vegetable Stir Fry with tofu");
    type2Veg.add("Moong Dal Chilla with mint chutney");
    type2Veg.add("Vegetable Soup with flaxseed crackers");
    type2Veg.add("Sprouted Moong Salad with lemon dressing");
    type2Veg.add("Bajra (Pearl Millet) Roti with dal");
    type2Veg.add("Vegetable Stew with small appam");
    type2Veg.add("Quinoa Upma with vegetables");
    type2Veg.add("Vegetable Kurma with jowar roti");
    type2Veg.add("Dal Tadka with bajra roti");
    type2Veg.add("Vegetable Khichdi with yogurt");
    type2Veg.add("Pesarattu (Green Gram Dosa) with coconut chutney");
    type2Veg.add("Vegetable Pongal with sambar");
    type2Veg.add("Oats Idli with tomato chutney");
    type2Veg.add("Vegetable Biryani with cucumber raita");
    type2Veg.add("Masala Dosa with mint chutney");
    type2Veg.add("Vegetable Pulao with raita");
    type2Veg.add("Dal Makhani with multigrain roti");
    type2Veg.add("Vegetable Uttapam with sambar");
    type2Veg.add("Soya Chunks Curry with brown rice");
    type2Recs.put("Veg", type2Veg);
    
    List<String> type2NonVeg = new ArrayList<>();
    type2NonVeg.add("Nethili (Anchovy) Fish curry with millet rice");
    type2NonVeg.add("Chicken stew with appam (1 piece)");
    type2NonVeg.add("Egg white curry with whole wheat dosa");
    type2NonVeg.add("Fish moilee with small portion of red rice");
    type2NonVeg.add("Grilled prawns with vegetable stir fry");
    type2NonVeg.add("Chicken Roast with quinoa");
    type2NonVeg.add("Fish Tikka with salad");
    type2NonVeg.add("Egg Bhurji with multigrain roti");
    type2NonVeg.add("Prawn Curry with millet dosa");
    type2NonVeg.add("Chicken Tikka with salad");
    type2NonVeg.add("Fish Cutlet with cucumber raita");
    type2NonVeg.add("Egg Fried Rice with vegetables (small portion)");
    type2NonVeg.add("Chicken Curry with bajra roti");
    type2NonVeg.add("Fish Puttu with coconut milk");
    type2NonVeg.add("Prawn Masala with quinoa");
    type2NonVeg.add("Chicken Sukka with ragi roti");
    type2NonVeg.add("Egg Roast with whole wheat bread");
    type2NonVeg.add("Fish Molee with small appam");
    type2NonVeg.add("Crab Masala with salad");
    type2NonVeg.add("Chicken Biryani with raita (small portion)");
    type2NonVeg.add("Mutton Curry with millet roti");
    type2NonVeg.add("Egg Dosa with mint chutney");
    type2NonVeg.add("Fish Fry with vegetable salad");
    type2NonVeg.add("Chicken 65 with cucumber raita");
    type2NonVeg.add("Prawn Fry with quinoa upma");
    type2NonVeg.add("Mutton Keema with multigrain roti");
    type2NonVeg.add("Chicken Chettinad with small portion of rice");
    type2NonVeg.add("Egg Curry with millet dosa");
    type2NonVeg.add("Fish Biryani with raita (small portion)");
    type2Recs.put("Non-Veg", type2NonVeg);
    foodRecommendations.put("Type 2", type2Recs);
    
    // Gestational diabetes recommendations
    Map<String, List<String>> gestationalRecs = new HashMap<>();
    List<String> gestationalVeg = new ArrayList<>();
    gestationalVeg.add("Paneer and vegetable stuffed roti with curd");
    gestationalVeg.add("Moong dal dosa with coconut chutney");
    gestationalVeg.add("Vegetable upma with flaxseeds");
    gestationalVeg.add("Soya chunks curry with brown rice");
    gestationalVeg.add("Sprouts salad with lemon dressing");
    gestationalVeg.add("Ragi (Finger Millet) Idli with sambar");
    gestationalVeg.add("Thinai (Foxtail Millet) Pongal with vegetables");
    gestationalVeg.add("Kambu (Pearl Millet) Koozh with buttermilk");
    gestationalVeg.add("Samai (Little Millet) Upma with vegetables");
    gestationalVeg.add("Varagu (Kodo Millet) Lemon Rice");
    gestationalVeg.add("Vegetable Stew with small appam");
    gestationalVeg.add("Moong Dal Khichdi with curd");
    gestationalVeg.add("Vegetable Biryani with raita (small portion)");
    gestationalVeg.add("Pesarattu (Green Gram Dosa) with ginger chutney");
    gestationalVeg.add("Oats Idli with tomato chutney");
    gestationalVeg.add("Vegetable Pulao with cucumber raita");
    gestationalVeg.add("Masala Dosa with coconut chutney");
    gestationalVeg.add("Vegetable Kurma with whole wheat roti");
    gestationalVeg.add("Soya Chunks Curry with brown rice");
    gestationalVeg.add("Sprouts Salad with lemon dressing");
    gestationalVeg.add("Vegetable Uttapam with sambar");
    gestationalVeg.add("Dal Tadka with jowar roti");
    gestationalVeg.add("Vegetable Khichdi with papad");
    gestationalVeg.add("Avial with small portion of red rice");
    gestationalVeg.add("Keerai (Spinach) Kootu with millet roti");
    gestationalVeg.add("Mixed Vegetable Sambar with quinoa");
    gestationalVeg.add("Vegetable Pongal with sambar");
    gestationalVeg.add("Paneer Tikka with multigrain roti");
    gestationalVeg.add("Vegetable Stir Fry with brown rice");
    gestationalVeg.add("Dal Makhani with bajra roti");
    gestationalRecs.put("Veg", gestationalVeg);
    
    List<String> gestationalNonVeg = new ArrayList<>();
    gestationalNonVeg.add("Boiled egg with whole wheat toast");
    gestationalNonVeg.add("Fish curry with small portion of rice");
    gestationalNonVeg.add("Chicken soup with vegetables");
    gestationalNonVeg.add("Grilled fish with quinoa upma");
    gestationalNonVeg.add("Egg white omelette with multigrain bread");
    gestationalNonVeg.add("Nethili (Anchovy) Fish Fry with millet rice");
    gestationalNonVeg.add("Chicken Biryani with raita (small portion)");
    gestationalNonVeg.add("Egg Bhurji with multigrain roti");
    gestationalNonVeg.add("Fish Molee with small appam");
    gestationalNonVeg.add("Prawn Curry with brown rice");
    gestationalNonVeg.add("Chicken Stew with whole wheat bread");
    gestationalNonVeg.add("Mutton Curry with bajra roti");
    gestationalNonVeg.add("Egg Roast with dosa");
    gestationalNonVeg.add("Fish Puttu with coconut milk");
    gestationalNonVeg.add("Chicken 65 with cucumber raita");
    gestationalNonVeg.add("Crab Masala with quinoa");
    gestationalNonVeg.add("Egg Fried Rice with vegetables (small portion)");
    gestationalNonVeg.add("Chicken Tikka with roti");
    gestationalNonVeg.add("Fish Biryani with raita (small portion)");
    gestationalNonVeg.add("Prawn Masala with millet dosa");
    gestationalNonVeg.add("Mutton Biryani with onion raita (small portion)");
    gestationalNonVeg.add("Chicken Curry with appam");
    gestationalNonVeg.add("Egg Dosa with chutney");
    gestationalNonVeg.add("Fish Cutlet with salad");
    gestationalNonVeg.add("Chicken Sukka with ragi roti");
    gestationalNonVeg.add("Prawn Fry with quinoa upma");
    gestationalNonVeg.add("Mutton Keema with whole wheat paratha");
    gestationalNonVeg.add("Chicken Roast with small portion of rice");
    gestationalNonVeg.add("Egg Curry with millet dosa");
    gestationalNonVeg.add("Fish Tikka with salad");
    gestationalRecs.put("Non-Veg", gestationalNonVeg);
    foodRecommendations.put("Gestational", gestationalRecs);
    
    // Default recommendations
    Map<String, List<String>> defaultRecs = new HashMap<>();
    List<String> defaultVeg = new ArrayList<>();
    defaultVeg.add("Mixed vegetable sambar with brown rice");
    defaultVeg.add("Dal tadka with jowar roti");
    defaultVeg.add("Vegetable kurma with millet dosa");
    defaultVeg.add("Pesarattu (Green Gram Dosa) with ginger chutney");
    defaultVeg.add("Vegetable biryani with raita (small portion)");
    defaultVeg.add("Ragi (Finger Millet) Idli with sambar");
    defaultVeg.add("Thinai (Foxtail Millet) Pongal with vegetables");
    defaultVeg.add("Kambu (Pearl Millet) Koozh with buttermilk");
    defaultVeg.add("Samai (Little Millet) Upma with vegetables");
    defaultVeg.add("Varagu (Kodo Millet) Lemon Rice");
    defaultVeg.add("Vegetable Stew with small appam");
    defaultVeg.add("Moong Dal Khichdi with curd");
    defaultVeg.add("Vegetable Biryani with raita (small portion)");
    defaultVeg.add("Pesarattu (Green Gram Dosa) with ginger chutney");
    defaultVeg.add("Oats Idli with tomato chutney");
    defaultVeg.add("Vegetable Pulao with cucumber raita");
    defaultVeg.add("Masala Dosa with coconut chutney");
    defaultVeg.add("Vegetable Kurma with whole wheat roti");
    defaultVeg.add("Soya Chunks Curry with brown rice");
    defaultVeg.add("Sprouts Salad with lemon dressing");
    defaultVeg.add("Vegetable Uttapam with sambar");
    defaultVeg.add("Dal Tadka with jowar roti");
    defaultVeg.add("Vegetable Khichdi with papad");
    defaultVeg.add("Avial with small portion of red rice");
    defaultVeg.add("Keerai (Spinach) Kootu with millet roti");
    defaultVeg.add("Mixed Vegetable Sambar with quinoa");
    defaultVeg.add("Vegetable Pongal with sambar");
    defaultVeg.add("Paneer Tikka with multigrain roti");
    defaultVeg.add("Vegetable Stir Fry with brown rice");
    defaultVeg.add("Dal Makhani with bajra roti");
    defaultRecs.put("Veg", defaultVeg);
    
    List<String> defaultNonVeg = new ArrayList<>();
    defaultNonVeg.add("Grilled fish with quinoa and greens");
    defaultNonVeg.add("Chicken curry with small portion of rice");
    defaultNonVeg.add("Egg curry with whole wheat roti");
    defaultNonVeg.add("Fish fry with vegetable salad");
    defaultNonVeg.add("Mutton curry with bajra roti");
    defaultNonVeg.add("Nethili (Anchovy) Fish Fry with millet rice");
    defaultNonVeg.add("Chicken Biryani with raita (small portion)");
    defaultNonVeg.add("Egg Bhurji with multigrain roti");
    defaultNonVeg.add("Fish Molee with small appam");
    defaultNonVeg.add("Prawn Curry with brown rice");
    defaultNonVeg.add("Chicken Stew with whole wheat bread");
    defaultNonVeg.add("Mutton Curry with bajra roti");
    defaultNonVeg.add("Egg Roast with dosa");
    defaultNonVeg.add("Fish Puttu with coconut milk");
    defaultNonVeg.add("Chicken 65 with cucumber raita");
    defaultNonVeg.add("Crab Masala with quinoa");
    defaultNonVeg.add("Egg Fried Rice with vegetables (small portion)");
    defaultNonVeg.add("Chicken Tikka with roti");
    defaultNonVeg.add("Fish Biryani with raita (small portion)");
    defaultNonVeg.add("Prawn Masala with millet dosa");
    defaultNonVeg.add("Mutton Biryani with onion raita (small portion)");
    defaultNonVeg.add("Chicken Curry with appam");
    defaultNonVeg.add("Egg Dosa with chutney");
    defaultNonVeg.add("Fish Cutlet with salad");
    defaultNonVeg.add("Chicken Sukka with ragi roti");
    defaultNonVeg.add("Prawn Fry with quinoa upma");
    defaultNonVeg.add("Mutton Keema with whole wheat paratha");
    defaultNonVeg.add("Chicken Roast with small portion of rice");
    defaultNonVeg.add("Egg Curry with millet dosa");
    defaultNonVeg.add("Fish Tikka with salad");
    
    defaultRecs.put("Non-Veg", defaultNonVeg);
    foodRecommendations.put("Other", defaultRecs);
    
    
    if(isLoggedIn) {
        // Get appropriate food recommendations based on user type and preference
        List<String> userFoodOptions = foodRecommendations
            .getOrDefault(user.getDiabetesType(), defaultRecs)
            .get(user.getFoodPreference());
        
        // Select 5 recommendations (rotating based on session counter)
        int recommendationCounter = session.getAttribute("recommendationCounter") != null ? 
            (Integer)session.getAttribute("recommendationCounter") : 0;
        List<String> selectedRecommendations = new ArrayList<>();
        
        for (int i = 0; i < 5 && i < userFoodOptions.size(); i++) {
            int index = (recommendationCounter + i) % userFoodOptions.size();
            selectedRecommendations.add(userFoodOptions.get(index));
        }
        
        // Update counter for next time
        session.setAttribute("recommendationCounter", (recommendationCounter + 5) % userFoodOptions.size());
        
        // Join recommendations with line breaks for display
        foodRecommendation = String.join("<br><br>• ", selectedRecommendations);
        foodRecommendation = "• " + foodRecommendation;
        
        // Calculate BMI and category
        double heightInMeters = user.getHeight() / 100;
        bmi = user.getWeight() / (heightInMeters * heightInMeters);
        
        if(bmi < 18.5) {
            bmiCategory = "Underweight";
            bmiBadgeClass = "bg-info";
        } else if(bmi < 25) {
            bmiCategory = "Normal";
            bmiBadgeClass = "bg-success";
        } else if(bmi < 30) {
            bmiCategory = "Overweight";
            bmiBadgeClass = "bg-warning";
        } else {
            bmiCategory = "Obese";
            bmiBadgeClass = "bg-danger";
        }
        
        // Blood sugar analysis
        if(user.getBloodSugarRange() != null && user.getBloodSugarRange().contains("-")) {
            String[] rangeParts = user.getBloodSugarRange().split("-");
            try {
                int lowerRange = Integer.parseInt(rangeParts[0].trim());
                if(lowerRange > 140) {
                    bloodSugarStatus = "High blood sugar detected";
                    bloodSugarAlertClass = "alert-danger";
                } else if(lowerRange < 70) {
                    bloodSugarStatus = "Low blood sugar warning";
                    bloodSugarAlertClass = "alert-warning";
                } else {
                    bloodSugarStatus = "Normal range";
                    bloodSugarAlertClass = "alert-success";
                }
            } catch(NumberFormatException e) {
                bloodSugarStatus = "Monitor regularly";
                bloodSugarAlertClass = "alert-secondary";
            }
        } else {
            bloodSugarStatus = "Monitor regularly";
            bloodSugarAlertClass = "alert-secondary";
        }
        
        // Activity recommendations based on profession and BMI
        if(user.getJobProfession() != null && user.getJobProfession().toLowerCase().contains("desk")) {
            activityRecommendation = "Desk job detected: Take a 5-minute walk every hour";
            if(bmi >= 25) {
                activityRecommendation += " and aim for 30 minutes of cardio after work";
            }
        } else {
            activityRecommendation = "Aim for 30 minutes of moderate exercise daily";
            if(bmi >= 25) {
                activityRecommendation += ", including strength training twice weekly";
            }
        }
        
        // Meal timing suggestion based on insulin usage
        if("Yes".equals(user.getInsulinUsage())) {
            mealTiming = "Space meals 4-5 hours apart to match insulin peaks";
        } else if(bmi >= 25) {
            mealTiming = "Consider smaller, more frequent meals to manage weight";
        } else {
            mealTiming = "Standard 3 meals per day recommended";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Health care food recommendation engine</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --success-color: #2ecc71;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
            --info-color: #1abc9c;
            --accent-color: #9b59b6;
        }
        
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        /* Logged In User Styles */
        .sidebar {
            background: linear-gradient(180deg, var(--secondary-color), var(--primary-color));
            color: white;
            height: 100vh;
            position: fixed;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            width: 250px;
            z-index: 1000;
        }
        
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        
        .dashboard-card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 20px;
            border: none;
            height: 100%;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        
        .nav-link {
            color: rgba(255,255,255,0.8);
            border-radius: 5px;
            margin-bottom: 5px;
            transition: all 0.3s;
        }
        
        .nav-link:hover, .nav-link.active {
            background-color: rgba(255,255,255,0.1);
            color: white;
            transform: translateX(5px);
        }
        
        .bmi-indicator {
            height: 10px;
            border-radius: 5px;
            background: linear-gradient(90deg, 
                var(--primary-color), 
                var(--success-color), 
                var(--warning-color), 
                var(--danger-color));
            margin-top: 5px;
            position: relative;
        }
        
        .bmi-marker {
            position: absolute;
            top: -20px;
            transform: translateX(-50%);
            color: var(--secondary-color);
            font-weight: bold;
            background: white;
            padding: 2px 6px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            font-size: 0.8rem;
        }
        
        .progress-thin {
            height: 6px;
        }
        
        /* Non-Logged In User Styles */
        .public-navbar {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .public-logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: white;
        }
        
        .public-nav-link {
            color: white;
            font-weight: 500;
            margin-left: 20px;
            transition: all 0.3s;
            position: relative;
        }
        
        .public-nav-link:hover {
            color: rgba(255,255,255,0.8);
        }
        
        .public-nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            background: white;
            bottom: -5px;
            left: 0;
            transition: width 0.3s;
        }
        
        .public-nav-link:hover::after {
            width: 100%;
        }
        
        .hero-section {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            padding: 80px 0 60px;
            border-radius: 0 0 15% 15%;
            margin-bottom: 40px;
        }
        
        .feature-card {
            border-radius: 15px;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            height: 100%;
            transition: transform 0.3s;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
        }
        
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: var(--primary-color);
        }
        
        .testimonial-card {
            border-radius: 15px;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 25px;
            margin-bottom: 20px;
            position: relative;
        }
        
        .testimonial-card::before {
            content: '\201C';
            font-size: 5rem;
            position: absolute;
            top: -20px;
            left: 10px;
            color: rgba(52, 152, 219, 0.1);
            font-family: Georgia, serif;
        }
        
        .auth-btn {
            border-radius: 30px;
            padding: 8px 25px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .auth-btn-login {
            background-color: transparent;
            border: 2px solid white;
            color: white;
        }
        
        .auth-btn-login:hover {
            background-color: white;
            color: var(--primary-color);
        }
        
        .auth-btn-signup {
            background-color: white;
            border: 2px solid white;
            color: var(--primary-color);
        }
        
        .auth-btn-signup:hover {
            background-color: rgba(255,255,255,0.9);
        }
        
        .food-recommendation-card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            border: none;
        }
        
        .food-recommendation-header {
            color: white;
            padding: 15px 20px;
        }
        
        .type1-header {
            background: linear-gradient(45deg, #3498db, #2980b9);
        }
        
        .type2-header {
            background: linear-gradient(45deg, #27ae60, #2ecc71);
        }
        
        .gestational-header {
            background: linear-gradient(45deg, #f39c12, #f1c40f);
        }
        
        @media (max-width: 991px) {
            .main-content {
                margin-left: 0;
            }
            
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                padding: 15px;
            }
            
            .sidebar .nav {
                display: flex;
                flex-wrap: wrap;
            }
            
            .sidebar .nav-item {
                width: 50%;
            }
        }
        
        @media (max-width: 767px) {
            .sidebar .nav-item {
                width: 100%;
            }
        }
        
                /* Chatbot styles */
        .chatbot-toggle {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 999;
        }
        
        .chatbot-toggle button {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            width: 65px;
            height: 65px;
            border: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
        }
        
        .chatbot-toggle button:hover {
            transform: scale(1.05);
        }
        
        #chatbotBox {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 350px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.25);
            z-index: 999;
            display: none;
            border-radius: var(--border-radius);
            border: none;
            overflow: hidden;
        }
        
        .chat-header {
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--primary-color) 100%);
            color: var(--light-text);
            padding: 15px;
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }
        
        #chatBox {
            height: 300px;
            overflow-y: auto;
            background: #f9f9f9;
            padding: 15px;
            border-radius: 0;
            margin-bottom: 0;
        }
        
        .message {
            padding: 10px 15px;
            border-radius: 20px;
            margin-bottom: 12px;
            max-width: 80%;
            word-wrap: break-word;
            clear: both;
            position: relative;
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .user-message {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
            float: right;
            border-bottom-right-radius: 5px;
        }
        
        .bot-message {
            background: #e9ecef;
            color: black;
            float: left;
            border-bottom-left-radius: 5px;
        }
        
        .input-group {
            background: #fff;
            border-top: 1px solid #eee;
            padding: 15px;
        }
        
        #userInput {
            border-radius: 30px 0 0 30px;
            padding: 10px 15px;
            border: 1px solid #ddd;
        }
        
        .send-btn {
            border-radius: 0 30px 30px 0;
            background: var(--accent-color);
            color: white;
            border: none;
        }
        
        
        
    </style>
</head>
<body>
    <% if(isLoggedIn) { %>
    <!-- LOGGED IN USER VIEW -->
    <!-- Sidebar Navigation -->
    <div class="sidebar p-4">
        <div class="text-center mb-4">
            <h4><i class="fas fa-utensils me-2"></i>Health care food recommendation engine </h4>
            <p class="small">Welcome back, <strong><%= user.getName() %></strong>!</p>
            <div class="progress progress-thin mb-2">
                <div class="progress-bar bg-success" style="width: 78%"></div>
            </div>
            <small>Profile completeness: 78%</small>
        </div>
        
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link active" href="index.jsp"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="foodRecommendations"><i class="fas fa-utensils me-2"></i>Food Recommendations</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="bmi.jsp"><i class="fas fa-chart-line me-2"></i>BMI Calculater</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="nutritionGuide.jsp"><i class="fas fa-book me-2"></i>Nutrition Guide</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="profileUpdate?id=<%=user.getId()%>"><i class="fas fa-cog me-2"></i>Settings</a>
            </li>
             <li class="nav-item">
                <a class="nav-link" href="logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
            </li>
        </ul>
        
        <div class="mt-4 pt-4 border-top">
            <small class="text-muted">Last login: Today</small>
        </div>
    </div>

    <!-- Main Content Area -->
    <div class="main-content">
        <!-- Header with Logout -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="text-primary"><i class="fas fa-tachometer-alt me-2"></i>Your Dashboard</h3>
                <p class="text-muted mb-0"><%= user.getDiabetesType() %> Diabetes Management</p>
            </div>
            <a href="logout" class="btn btn-outline-danger"><i class="fas fa-sign-out-alt me-1"></i> Logout</a>
              </div>
            


      

        <!-- Dashboard Cards Row 1 -->
        <div class="row">
            <!-- Profile Summary Card -->
            <div class="col-lg-4 col-md-6">
                <div class="card dashboard-card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title"><i class="fas fa-user-circle me-2"></i>Profile Summary</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <div class="flex-shrink-0">
                                <div class="bg-primary text-white rounded-circle p-3 text-center" 
                                     style="width: 60px; height: 60px; line-height: 40px;">
                                    <i class="fas fa-user fa-2x"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h5><%= user.getName() %></h5>
                                <p class="mb-0"><%= user.getAge() %> years • <%= user.getGender() %></p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-6 mb-3">
                                <strong>Diabetes Type:</strong> 
                                <span class="badge bg-info mt-1 d-block"><%= user.getDiabetesType() %></span>
                            </div>
                            <div class="col-6 mb-3">
                                <strong>Food Pref:</strong> 
                                <span class="badge bg-success mt-1 d-block"><%= user.getFoodPreference() %></span>
                            </div>
                            <div class="col-6">
                                <strong>Allergies:</strong> 
                                <span class="badge <%= (user.getAllergies() == null || user.getAllergies().isEmpty()) ? 
                                    "bg-secondary" : "bg-warning text-dark" %> mt-1 d-block">
                                    <%= (user.getAllergies() == null || user.getAllergies().isEmpty()) ? 
                                        "None" : user.getAllergies() %>
                                </span>
                            </div>
                            <div class="col-6">
                                <strong>Insulin:</strong> 
                                <span class="badge <%= user.getInsulinUsage().equals("Yes") ? 
                                    "bg-info" : "bg-secondary" %> mt-1 d-block">
                                    <%= user.getInsulinUsage() %>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Health Metrics Card -->
            <div class="col-lg-4 col-md-6">
                <div class="card dashboard-card">
                    <div class="card-header bg-info text-white">
                        <h5 class="card-title"><i class="fas fa-heartbeat me-2"></i>Health Metrics</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-4">
                            <div class="d-flex justify-content-between mb-2">
                                <h6 class="mb-0">Body Mass Index</h6>
                                <span class="badge <%= bmiBadgeClass %>"><%= String.format("%.1f", bmi) %> (<%= bmiCategory %>)</span>
                            </div>
                            <div class="d-flex justify-content-between small text-muted mb-1">
                                <span>Underweight</span>
                                <span>Normal</span>
                                <span>Overweight</span>
                                <span>Obese</span>
                            </div>
                            <div class="bmi-indicator">
                                <div class="bmi-marker" id="bmiMarker">
                                    <%= String.format("%.1f", bmi) %>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <div class="text-center p-2 bg-light rounded">
                                    <h6>Weight</h6>
                                    <h4 class="text-primary"><%= user.getWeight() %> <small class="text-muted">kg</small></h4>
                                    <% if(bmi >= 25) { %>
                                        <small class="text-danger">Consider reducing by 5-10%</small>
                                    <% } else if(bmi < 18.5) { %>
                                        <small class="text-info">Consider healthy weight gain</small>
                                    <% } %>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="text-center p-2 bg-light rounded">
                                    <h6>Height</h6>
                                    <h4 class="text-primary"><%= user.getHeight() %> <small class="text-muted">cm</small></h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Blood Sugar Card -->
            <div class="col-lg-4 col-md-12">
                <div class="card dashboard-card">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="card-title"><i class="fas fa-tint me-2"></i>Blood Sugar</h5>
                    </div>
                    <div class="card-body">
                        <div class="text-center mb-3">
                            <% if(user.getBloodSugarRange() != null && !user.getBloodSugarRange().isEmpty()) { %>
                                <h1 class="display-4"><%= user.getBloodSugarRange() %></h1>
                                <p class="mb-0 text-muted">mg/dL</p>
                            <% } else { %>
                                <div class="alert alert-secondary">No blood sugar data recorded</div>
                            <% } %>
                        </div>
                        <div class="alert <%= bloodSugarAlertClass %>">
                            <i class="fas <%= bloodSugarAlertClass.equals("alert-danger") ? "fa-exclamation-triangle" : 
                                          bloodSugarAlertClass.equals("alert-warning") ? "fa-exclamation-circle" : 
                                          "fa-check-circle" %> me-2"></i>
                            <%= bloodSugarStatus %>
                        </div>
                        <div class="progress progress-thin mb-2">
                            <div class="progress-bar bg-success" style="width: 30%"></div>
                            <div class="progress-bar bg-warning" style="width: 40%"></div>
                            <div class="progress-bar bg-danger" style="width: 30%"></div>
                        </div>
                        <div class="d-flex justify-content-between small text-muted">
                            <span>Low</span>
                            <span>Normal</span>
                            <span>High</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Dashboard Cards Row 2 -->
        <div class="row mt-4">
            <!-- Lifestyle Factors Card -->
            <div class="col-lg-6">
                <div class="card dashboard-card">
                    <div class="card-header bg-secondary text-white">
                        <h5 class="card-title"><i class="fas fa-running me-2"></i>Lifestyle Factors</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="p-3 bg-light rounded">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-smoking <%= user.getSmokingHabit().equals("Yes") ? "text-danger" : "text-success" %> fa-2x"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-1">Smoking</h6>
                                            <p class="mb-0 small"><%= user.getSmokingHabit().equals("Yes") ? 
                                                "<span class='text-danger'>Consider quitting</span> - increases diabetes complications" : 
                                                "<span class='text-success'>Good!</span> No smoking detected" %></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="p-3 bg-light rounded">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-wine-glass-alt <%= user.getAlcoholHabit().equals("Yes") ? "text-warning" : "text-success" %> fa-2x"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-1">Alcohol</h6>
                                            <p class="mb-0 small"><%= user.getAlcoholHabit().equals("Yes") ? 
                                                "<span class='text-warning'>Limit to 1 drink/day</span> - can affect blood sugar" : 
                                                "<span class='text-success'>Good!</span> No alcohol detected" %></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="p-3 bg-light rounded">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-syringe <%= user.getInsulinUsage().equals("Yes") ? "text-info" : "text-secondary" %> fa-2x"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-1">Insulin Usage</h6>
                                            <p class="mb-0 small"><%= user.getInsulinUsage().equals("Yes") ? 
                                                "<span class='text-info'>Monitor closely</span> - track carb intake" : 
                                                "No insulin usage reported" %></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="p-3 bg-light rounded">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <i class="fas fa-briefcase text-primary fa-2x"></i>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-1">Profession</h6>
                                            <p class="mb-0 small"><%= user.getJobProfession() != null ? 
                                                user.getJobProfession() : "Not specified" %></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="alert alert-info">
                            <h6><i class="fas fa-clock me-2"></i>Meal Timing</h6>
                            <p class="mb-0"><%= mealTiming %></p>
                        </div>
                    </div>
                </div>
            </div>
			
			<!-- Quick Recommendations Card -->
<div class="col-lg-6">
    <div class="card dashboard-card">
        <div class="card-header bg-success text-white">
            <h5 class="card-title"><i class="fas fa-lightbulb me-2"></i>Personalized Recommendations</h5>
        </div>
        <div class="card-body">
            <div class="alert alert-info">
                <div class="d-flex align-items-start">
                    <i class="fas fa-utensils mt-1 me-3"></i>
                    <div>
                        <h6>Today's Food Suggestion</h6>
                        <p class="mb-1"><%= foodRecommendation %></p>
<% if(user.getAllergies() != null && !user.getAllergies().isEmpty()) { 
    String[] allergyTips = {
        // Breakfast
        "Ragi dosa with mint chutney - gluten-free & low GI",
        "Moong dal chilla with coriander chutney - high protein",
        "Jowar roti with lauki (bottle gourd) sabzi - light & nutritious",
        "Poha (flattened rice) with peanuts & veggies - easy to digest",
        "Quinoa upma with spinach - protein-rich & gluten-free",
        "Besan (chickpea flour) cheela with pudina chutney - diabetic-friendly",
        "Steamed dhokla (made with chana dal) - probiotic & light",
        "Samak rice idli - gluten-free alternative to rice idli",
        
        // Lunch/Dinner
        "Bajra roti with methi dal - high fiber & controls sugar",
        "Karela (bitter gourd) stir-fry with jowar bhakri - natural blood sugar regulator",
        "Palak paneer with quinoa roti - low-carb & iron-rich",
        "Lauki chana dal curry with brown rice - balanced meal",
        "Grilled fish with sautéed vegetables - lean protein & omega-3",
        "Sprouted moong salad with lemon & flaxseeds - high protein & fiber",
        "Tinda (apple gourd) sabzi with bajra roti - low-calorie & nutritious",
        "Dudhi (bottle gourd) thepla with curd - light & gluten-free",
        "Masoor dal soup with roasted makhana - diabetic-friendly snack",
        
        // Snacks
        "Roasted chana (black chickpeas) - crunchy & protein-packed",
        "Makhana (fox nuts) with cinnamon - low-calorie & blood sugar-friendly",
        "Cucumber & carrot sticks with hummus - fiber-rich snack",
        "Handful of almonds & walnuts - healthy fats for sugar control",
        "Greek yogurt with chia seeds - probiotic & low sugar",
        "Avocado chat with black salt - healthy fats & no carbs",
        
        // Light Meals
        "Vegetable stew with coconut milk (use less coconut) - creamy & safe",
        "Masala oats with veggies - gluten-free & slow-digesting",
        "Sambar with drumstick & bottle gourd - diabetic-friendly lentils",
        "Grilled chicken with sautéed mushrooms - lean protein option",
        
        // Desserts (Diabetic-safe)
        "Dates & nuts ladoo (no sugar added) - natural sweetness",
        "Ragi malt with almond milk - calcium-rich & sugar-free",
        "Chia seed pudding with berries - antioxidant-rich dessert",
        "Coconut & jaggery-free ladoo (made with sesame seeds) - healthy fats",
        
        // Extra Tips
        "Drink methi (fenugreek) water daily - helps regulate blood sugar",
        "Replace sugar with stevia in beverages - zero-calorie sweetener",
        "Opt for small, frequent meals - prevents sugar spikes"
    };
    java.util.Random rand = new java.util.Random();
    int tipIndex = rand.nextInt(allergyTips.length);
%>                            <small class="text-muted">Allergy-friendly tip: <%= allergyTips[tipIndex] %></small>
                        <% } %>
                    </div>
                </div>
            </div>
            
            <!-- Add this new button below the recommendations -->
            <div class="text-center mt-3">
                <a href="filterFoods.jsp" class="btn btn-primary">
                    <i class="fas fa-filter me-2"></i>Filter Your Foods
                </a>
            </div>
            
            <div class="alert alert-warning">
                <!-- Rest of your existing content -->
                <!-- ... -->
            </div>
            <!-- ... -->
        </div>
    </div>
</div>
			
            
            <div class="alert alert-warning">
    <div class="d-flex align-items-start">
        <i class="fas fa-dumbbell mt-1 me-3"></i>
        <div>
            <h6>Activity Plan</h6>
            <% 
            String[] exercises;
            java.util.Random exerciseRand = new java.util.Random();
            
            if(bmi < 18.5) {
                exercises = new String[] {
                    // Strength & Weight Gain Focus
                    "Morning sun salutations (5 rounds)",
                    "Brisk walking for 20 minutes",
                    "Wall push-ups (10 reps, 3 sets)",
                    "Gentle cycling for 15 minutes",
                    "Chair squats (10 reps, 3 sets)",
                    "Resistance band pulls (12 reps, 2 sets)",
                    "Dumbbell curls (light weights, 8 reps)",
                    "Yoga: Virabhadrasana (Warrior pose) - 30 sec each side",
                    "Leg raises (lying down, 10 reps)",
                    "Bridge pose (hold for 15 seconds, 3 reps)",
                    "Climbing stairs slowly (5 minutes)",
                    "Standing calf raises (15 reps)",
                    "Seated row with resistance band (10 reps)",
                    "Plank (modified on knees, 20 seconds)",
                    "Pilates roll-ups (8 reps)",

                    // Lifestyle Mods
                    "Carry groceries to build arm strength",
                    "Park farther away to add walking steps",
                    "Take the stairs instead of elevators",
                    "Play badminton or table tennis for fun activity",
                    "Dance to 3 favorite songs daily"
                };
            } else if(bmi >= 25) {
                exercises = new String[] {
                    // Weight Loss Focus
                    "Brisk walking for 30 minutes",
                    "Stair climbing for 10 minutes",
                    "Standing side bends (15 each side)",
                    "Seated leg lifts (10 reps each leg)",
                    "Arm circles (30 seconds forward/backward)",
                    "Jumping jacks (1 minute, 3 sets)",
                    "High knees (30 seconds, 2 sets)",
                    "Butt kicks (30 seconds, 2 sets)",
                    "Wall sit (hold for 30 seconds)",
                    "Standing oblique crunches (12 each side)",
                    "Mountain climbers (20 reps)",
                    "Chair dips (10 reps, 3 sets)",
                    "Speed walking in place (5 minutes)",
                    "Zumba or dance workout (15 minutes)",
                    "Swimming (20 minutes)",

                    // Core & Cardio
                    "Bicycle crunches (15 reps each side)",
                    "Russian twists (with water bottle, 20 reps)",
                    "Plank (hold for 30 seconds, 3 reps)",
                    "Burpees (modified, 8 reps)",
                    "Jump rope (2 minutes, 3 sets)",

                    // Lifestyle Mods
                    "Walk while talking on phone",
                    "Stand up every 30 minutes at work",
                    "House cleaning at double speed",
                    "Gardening for 20 minutes",
                    "Play with kids/pets actively for 15 minutes"
                };
            } else {
                exercises = new String[] {
                    // Maintenance & General Fitness
                    "30-minute walk in your neighborhood",
                    "Basic yoga stretches (15 minutes)",
                    "Gardening or household chores",
                    "Play with children/pets actively",
                    "Swimming or water exercises",
                    "Cycling (20 minutes at moderate pace)",
                    "Tai chi (10 minutes)",
                    "Surya Namaskar (3 rounds)",
                    "Balance exercises: Tree pose (30 sec each leg)",
                    "Foam rolling for muscle relaxation",
                    "Deep breathing exercises (5 minutes)",
                    "Desk stretches (every 2 hours)",
                    "Park farther away for extra steps",
                    "Take stairs instead of elevator",
                    "Carry shopping bags (moderate weight)",

                    // Strength & Flexibility
                    "Bodyweight squats (12 reps, 3 sets)",
                    "Lunges (10 reps each leg)",
                    "Superman holds (20 seconds, 3 reps)",
                    "Cat-Cow stretches (10 reps)",
                    "Side-lying leg lifts (12 each side)"
                };
            }
            int exerciseIndex = exerciseRand.nextInt(exercises.length);
            %>
            <p class="mb-1"><%= exercises[exerciseIndex] %></p>
            <% if(bmi >= 25) { %>
                <small class="text-muted">Weight loss tip: Replace white rice with millets like kambu or varagu twice weekly</small>
            <% } else if(bmi < 18.5) { %>
                <small class="text-muted">Try adding banana with curd rice as evening snack for healthy weight gain</small>
            <% } else { %>
                <small class="text-muted">Maintenance tip: Include 1 serving of leafy greens daily for micronutrients</small>
            <% } %>
        </div>
    </div>
</div>
            
            <div class="alert alert-primary">
                <div class="d-flex align-items-start">
                    <i class="fas fa-spa mt-1 me-3"></i>
                    <div>
                        <h6>Daily Wellness Tip</h6>
                        <%
                        String[] wellnessTips = {
                        	    // Morning routines
                        	    "Drink warm water with 1 tsp fenugreek (vendhayam) soaked overnight - controls blood sugar",
                        	    "Chew 2-3 neem leaves with 1 tulsi leaf on empty stomach - boosts immunity",
                        	    "Apply gingelly oil (nalla ennai) before bath - improves skin and joint health",
                        	    
                        	    // Food remedies
                        	    "Have 1 tsp chyawanprash with warm milk - builds immunity (especially in winter)",
                        	    "Drink buttermilk with crushed ginger and curry leaves after meals - aids digestion",
                        	    "Soak 10 black raisins (unakkai) overnight, eat next morning - natural iron source",
                        	    
                        	    // Traditional practices
                        	    "Walk barefoot on grass for 10 mins daily - grounds body and reduces stress",
                        	    "Sleep on a kora grass mat - keeps body cool and improves sleep quality",
                        	    "Use a wooden roller (uruttu kattai) for foot massage - improves circulation",

                        	    
                        	    
                        	    
                        	    
                        	    
                        	    
                        	    
                        	    
                        	    
                        	    
                        	    
                        	    
                        	    // Seasonal tips
                        	    "In summer, drink panagam (jaggery+water+pepper) - cools the body",
                        	    "In monsoon, add pepper and turmeric to warm milk - prevents seasonal illnesses",
                        	    "In winter, apply ghee inside nostrils - prevents dryness and infections",
                        	    
                        	    // Women's health
                        	    "After childbirth, drink sukku coffee (dry ginger coffee) - aids recovery",
                        	    "During periods, have sesame (ellu) ladoo - maintains iron levels",
                        	    
                        	    // Mental wellness
                        	    "Listen to carnatic music for 15 mins daily - reduces anxiety",
                        	    "Practice deep breathing facing east during sunrise - energizes mind",
                        	    "Keep tulsi plant in northeast corner of home - purifies air and mind"
                        	};
                        java.util.Random wellnessRand = new java.util.Random();
                        int wellnessIndex = wellnessRand.nextInt(wellnessTips.length);
                        %>
                        <p class="mb-0"><%= wellnessTips[wellnessIndex] %></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

            
            
            
            
            
        
        
                       <!-- Enhanced Chatbot Box -->
    <div class="chatbot-toggle">
        <button onclick="toggleChatbot()" class="btn btn-success rounded-circle">
            <i class="fas fa-robot"></i>
        </button>
    </div>
    
    
        <div id="chatbotBox" class="card">
        <div class="chat-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="fas fa-robot me-2"></i> Healthcare Assistant</h5>
            <button onclick="toggleChatbot()" class="btn btn-sm text-white">
                <i class="fas fa-times"></i>
            </button>
        </div>

        <div id="chatBox">
            <!-- Messages will appear here -->
        </div>

        <div class="input-group">
            <input type="text" id="userInput" class="form-control" placeholder="Type your health question..." 
                onkeypress="if(event.key === 'Enter') sendMessage()">
            <button onclick="sendMessage()" class="btn send-btn">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>

    <script>
        // Toggle chatbot visibility
        function toggleChatbot() {
            const chatbotBox = document.getElementById("chatbotBox");
            if (chatbotBox.style.display === "none") {
                chatbotBox.style.display = "block";
                // Initialize with welcome message when first opened
                if (document.getElementById("chatBox").children.length === 0) { <%= user.getName() %>
                    addBotMessage("Hello <%= user.getName()%>! 👋 How can I assist you with your health today?");
                }
            } else {
                chatbotBox.style.display = "none";
            }
        }

        function sendMessage() {
            const userInput = document.getElementById("userInput");
            const message = userInput.value.trim();
            
            if (message === "") return;
            
            // Add user message to chat
            addUserMessage(message);
            userInput.value = "";
            
            // Process and show bot response after a short delay
            setTimeout(() => {
                const response = getBotResponse(message);
                addBotMessage(response);
            }, 500);
        }

        function addUserMessage(message) {
            const chatBox = document.getElementById("chatBox");
            const messageElement = document.createElement("div");
            messageElement.className = "message user-message";
            messageElement.textContent = message;
            chatBox.appendChild(messageElement);
            chatBox.scrollTop = chatBox.scrollHeight;
        }

        function addBotMessage(message) {
            const chatBox = document.getElementById("chatBox");
            const messageElement = document.createElement("div");
            messageElement.className = "message bot-message";
            messageElement.textContent = message;
            chatBox.appendChild(messageElement);
            chatBox.scrollTop = chatBox.scrollHeight;
        }

        function getBotResponse(message) {
            message = message.toLowerCase();

            if (message.includes("hi") || message.includes("hello")) {
                return "Hello there! How can I help you with your health today?";
            }
            else if (message.includes("bmi")) {
                return "BMI (Body Mass Index) is a measure of body fat based on height and weight. You can calculate it using our BMI calculator tool!";
            }
            else if (message.includes("diet")) {
                return "A balanced diet should include:\n- Fruits & vegetables\n- Whole grains\n- Lean proteins\n- Healthy fats\n- Plenty of water";
            }
            else if (message.includes("exercise") || message.includes("workout")) {
                return "For good health, aim for:\n- 150 mins moderate exercise weekly\n- Strength training 2x/week\n- Stretching daily\n- Less sitting time";
            }
            else if (message.includes("weight loss")) {
                return "Healthy weight loss tips:\n1. Eat more whole foods\n2. Control portion sizes\n3. Stay hydrated\n4. Exercise regularly\n5. Get enough sleep";
            }
            else if (message.includes("mental health")) {
                return "Mental health is crucial! Try:\n- Daily mindfulness\n- Regular exercise\n- Social connections\n- Quality sleep\n- Professional help if needed";
            }
            else if (message.includes("back pain")) {
                return "For back pain relief:\n- Practice good posture\n- Take regular breaks from sitting\n- Do gentle stretching\n- Strengthen core muscles\n- Consider ergonomic furniture";
            }
            else if (message.includes("eye strain")) {
                return "To reduce eye strain:\n- Follow the 20-20-20 rule\n- Adjust monitor brightness\n- Use blue light filters\n- Ensure proper lighting\n- Keep screens at arm's length";
            }
            else {
                return "I'm not sure I understand. You can ask me about:\n- BMI\n- Diet\n- Exercise\n- Weight loss\n- Mental health\n- Back pain\n- Eye strain";
            }
        }
    </script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Set BMI marker position
        window.onload = function() {
            <% if(isLoggedIn) { %>
                var bmiMarker = document.getElementById('bmiMarker');
                // Position based on BMI (18.5, 25, 30 are the thresholds)
                // Calculate position percentage
                var bmiValue = <%= bmi %>;
                var position = 0;
                
                if(bmiValue < 18.5) {
                    position = (bmiValue / 18.5) * 25;
                } else if(bmiValue < 25) {
                    position = 25 + ((bmiValue - 18.5) / 6.5) * 25;
                } else if(bmiValue < 30) {
                    position = 50 + ((bmiValue - 25) / 5) * 25;
                } else {
                    position = 75 + Math.min(((bmiValue - 30) / 10) * 25, 25);
                }
                
                // Ensure position is within bounds
                position = Math.max(0, Math.min(100, position));
                bmiMarker.style.left = position + '%';
            <% } %>
        };
    </script>
        

        
        <!-- Footer -->
        <footer class="mt-5 mb-3 text-center text-muted">
            <p>&copy; 2025 Health care food recommendation engine. All rights reserved.</p>
        </footer>
    </div>
    <% } else { %>
    <!-- NON-LOGGED IN USER VIEW -->
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg public-navbar">
        <div class="container">
            <a class="navbar-brand public-logo" href="#"><i class="fas fa-utensils me-2"></i>Food Recommendation</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link public-nav-link active" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link public-nav-link" href="#features">Features</a>
                    </li>
 
                    <li class="nav-item">
                        <a class="nav-link public-nav-link" href="#recommendations">Recommendations</a>
                    </li>
                </ul>
                <div class="ms-lg-4">
                    <a href="login.jsp" class="btn auth-btn auth-btn-login me-2">Login</a>
                    <a href="register.jsp" class="btn auth-btn auth-btn-signup">Sign Up</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4">HEALTH CARE FOOD RECOMMENDATION ENGINE</h1>
                    <p class="lead mb-4">Get personalized meal recommendations based on your diabetes type, preferences, and health metrics.</p>
                    <div class="mt-5">
                        <a href="register.jsp" class="btn btn-light btn-lg me-3">Get Started</a>
                        <a href="#features" class="btn btn-outline-light btn-lg">Learn More</a>
                    </div>
                </div>
                <div class="col-lg-6 d-none d-lg-block">
                    <div class="text-center">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5" id="features">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Our Features</h2>
                <p class="lead text-muted">Tools designed for better diabetes management</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card feature-card p-4">
                        <div class="text-center">
                            <i class="fas fa-utensils feature-icon"></i>
                            <h4>Personalized Food Recommendations</h4>
                            <p class="text-muted">Get meal suggestions tailored to your diabetes type, BMI, and preferences.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card feature-card p-4">
                        <div class="text-center">
                            <i class="fas fa-chart-line feature-icon"></i>
                            <h4>Health Metrics Tracking</h4>
                            <p class="text-muted">Monitor your BMI, blood sugar levels, and other health indicators.</p>
                        </div>
                    </div>
                </div>
  
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="py-5 bg-light" id="testimonials">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">What Our Users Say</h2>
                <p class="lead text-muted">Success stories from people managing diabetes effectively</p>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="testimonial-card">
                        <div class="mb-3">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                        </div>
                        <p class="mb-4">"The food recommendations have helped me maintain stable blood sugar levels. I've lost 15 pounds and my A1C dropped!"</p>
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-primary text-white rounded-circle p-2 text-center" style="width: 40px; height: 40px; line-height: 25px;">
                                    <i class="fas fa-user"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="mb-0">Sarah Johnson</h6>
                                <small class="text-muted">Type 2 Diabetes, 45</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="testimonial-card">
                        <div class="mb-3">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                        </div>
                        <p class="mb-4">"As someone with Type 1 diabetes, this app has been a game-changer. The carb counting guidance has made insulin dosing so much easier."</p>
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-primary text-white rounded-circle p-2 text-center" style="width: 40px; height: 40px; line-height: 25px;">
                                    <i class="fas fa-user"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="mb-0">Michael Davis</h6>
                                <small class="text-muted">Type 1 Diabetes, 32</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="testimonial-card">
                        <div class="mb-3">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star-half-alt text-warning"></i>
                        </div>
                        <p class="mb-4">"During my pregnancy, managing gestational diabetes was stressful. This app provided essential guidance that kept both me and my baby healthy."</p>
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-primary text-white rounded-circle p-2 text-center" style="width: 40px; height: 40px; line-height: 25px;">
                                    <i class="fas fa-user"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="mb-0">Emily Rodriguez</h6>
                                <small class="text-muted">Gestational Diabetes, 29</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Food Recommendations Section -->
    <section class="py-5" id="recommendations">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Sample Food Recommendations</h2>
                <p class="lead text-muted">See what personalized meal plans look like</p>
            </div>
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <div class="food-recommendation-card">
                        <div class="food-recommendation-header type1-header">
                            <h4><i class="fas fa-utensils me-2"></i>Type 1 Diabetes</h4>
                        </div>
                        <div class="card-body">
                            <h5>Vegetarian Option</h5>
                            <p>Quinoa with roasted vegetables (45g carbs) + insulin dose as directed</p>
                            <hr>
                            <h5>Non-Vegetarian Option</h5>
                            <p>Grilled salmon with asparagus (30g carbs) + insulin dose as directed</p>
                            <div class="alert alert-info mt-3">
                                <small><i class="fas fa-info-circle me-1"></i> Type 1 recommendations include carb counting to assist with insulin dosing</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-4">
                    <div class="food-recommendation-card">
                        <div class="food-recommendation-header type2-header">
                            <h4><i class="fas fa-utensils me-2"></i>Type 2 Diabetes</h4>
                        </div>
                        <div class="card-body">
                            <h5>Vegetarian Option</h5>
                            <p>Lentil soup with whole grain bread (Low glycemic)</p>
                            <hr>
                            <h5>Non-Vegetarian Option</h5>
                            <p>Baked chicken with steamed broccoli and cauliflower rice</p>
                            <div class="alert alert-success mt-3">
                                <small><i class="fas fa-info-circle me-1"></i> Type 2 recommendations focus on low glycemic index foods</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-4">
                    <div class="food-recommendation-card">
                        <div class="food-recommendation-header gestational-header">
                            <h4><i class="fas fa-utensils me-2"></i>Gestational Diabetes</h4>
                        </div>
                        <div class="card-body">
                            <h5>Vegetarian Option</h5>
                            <p>Greek yogurt with berries and nuts</p>
                            <hr>
                            <h5>Non-Vegetarian Option</h5>
                            <p>Turkey and avocado wrap on whole wheat</p>
                            <div class="alert alert-warning mt-3">
                                <small><i class="fas fa-info-circle me-1"></i> Gestational recommendations prioritize maternal and baby health</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center mt-4">
                <p>Want personalized recommendations based on your health profile?</p>
                <a href="register.jsp" class="btn btn-primary btn-lg">Create Your Account</a>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="py-5 bg-primary text-white">
        <div class="container text-center">
            <h2 class="mb-4">Ready to Take Control of Your Diabetes?</h2>
            <p class="lead mb-4">Join thousands of users who are managing their diabetes effectively with our personalized approach.</p>
            <a href="register.jsp" class="btn btn-light btn-lg">Sign Up Now - It's Free!</a>
        </div>
    </section>
    
  <!--  CHATBOT -->
  
         <!-- Enhanced Chatbot Box -->
    <div class="chatbot-toggle">
        <button onclick="toggleChatbot()" class="btn btn-success rounded-circle">
            <i class="fas fa-robot"></i>
        </button>
    </div>
    
    
        <div id="chatbotBox" class="card">
        <div class="chat-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="fas fa-robot me-2"></i> Healthcare Assistant</h5>
            <button onclick="toggleChatbot()" class="btn btn-sm text-white">
                <i class="fas fa-times"></i>
            </button>
        </div>

        <div id="chatBox">
            <!-- Messages will appear here -->
        </div>

        <div class="input-group">
            <input type="text" id="userInput" class="form-control" placeholder="Type your health question..." 
                onkeypress="if(event.key === 'Enter') sendMessage()">
            <button onclick="sendMessage()" class="btn send-btn">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>

    <script>
        // Toggle chatbot visibility
        function toggleChatbot() {
            const chatbotBox = document.getElementById("chatbotBox");
            if (chatbotBox.style.display === "none") {
                chatbotBox.style.display = "block";
                // Initialize with welcome message when first opened
                if (document.getElementById("chatBox").children.length === 0) {
                    addBotMessage("Hello! 👋 How can I assist you with your health today?");
<%--                     addBotMessage("Hello <%= user.getName() %>! 👋 How can I assist you with your health today?"); --%>
                }
            } else {
                chatbotBox.style.display = "none";
            }
        }

        function sendMessage() {
            const userInput = document.getElementById("userInput");
            const message = userInput.value.trim();
            
            if (message === "") return;
            
            // Add user message to chat
            addUserMessage(message);
            userInput.value = "";
            
            // Process and show bot response after a short delay
            setTimeout(() => {
                const response = getBotResponse(message);
                addBotMessage(response);
            }, 500);
        }

        function addUserMessage(message) {
            const chatBox = document.getElementById("chatBox");
            const messageElement = document.createElement("div");
            messageElement.className = "message user-message";
            messageElement.textContent = message;
            chatBox.appendChild(messageElement);
            chatBox.scrollTop = chatBox.scrollHeight;
        }

        function addBotMessage(message) {
            const chatBox = document.getElementById("chatBox");
            const messageElement = document.createElement("div");
            messageElement.className = "message bot-message";
            messageElement.textContent = message;
            chatBox.appendChild(messageElement);
            chatBox.scrollTop = chatBox.scrollHeight;
        }

        function getBotResponse(message) {
            message = message.toLowerCase();

            if (message.includes("hi") || message.includes("hello")) {
                return "Hello there! How can I help you with your health today?";
            }
            else if (message.includes("bmi")) {
                return "BMI (Body Mass Index) is a measure of body fat based on height and weight. You can calculate it using our BMI calculator tool!";
            }
            else if (message.includes("diet")) {
                return "A balanced diet should include:\n- Fruits & vegetables\n- Whole grains\n- Lean proteins\n- Healthy fats\n- Plenty of water";
            }
            else if (message.includes("exercise") || message.includes("workout")) {
                return "For good health, aim for:\n- 150 mins moderate exercise weekly\n- Strength training 2x/week\n- Stretching daily\n- Less sitting time";
            }
            else if (message.includes("weight loss")) {
                return "Healthy weight loss tips:\n1. Eat more whole foods\n2. Control portion sizes\n3. Stay hydrated\n4. Exercise regularly\n5. Get enough sleep";
            }
            else if (message.includes("mental health")) {
                return "Mental health is crucial! Try:\n- Daily mindfulness\n- Regular exercise\n- Social connections\n- Quality sleep\n- Professional help if needed";
            }
            else if (message.includes("back pain")) {
                return "For back pain relief:\n- Practice good posture\n- Take regular breaks from sitting\n- Do gentle stretching\n- Strengthen core muscles\n- Consider ergonomic furniture";
            }
            else if (message.includes("eye strain")) {
                return "To reduce eye strain:\n- Follow the 20-20-20 rule\n- Adjust monitor brightness\n- Use blue light filters\n- Ensure proper lighting\n- Keep screens at arm's length";
            }
            else {
                return "I'm not sure I understand. You can ask me about:\n- BMI\n- Diet\n- Exercise\n- Weight loss\n- Mental health\n- Back pain\n- Eye strain";
            }
        }
    </script>
  
  
  
  
  
    
    

    <!-- Footer -->
    <footer class="py-4 bg-dark text-white">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5><i class="fas fa-utensils me-2"></i>Health care food recommendation engine</h5>
                    <p>Helping you manage diabetes through smart food choices.</p>
                </div>
                <div class="col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Home</a></li>
                        <li><a href="#features" class="text-white">Features</a></li>
                        <li><a href="#testimonials" class="text-white">Testimonials</a></li>
                        <li><a href="#recommendations" class="text-white">Recommendations</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Contact Us</h5>
                    <p><i class="fas fa-envelope me-2"></i>mbrindha1200@gmail.com</p>

                </div>
            </div>
            <hr class="my-4">
            <div class="text-center">
                <p class="mb-0">&copy; 2025 Healthcare food recommendation engine. All rights reserved.</p>
            </div>
        </div>
    </footer>
    <% } %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set BMI marker position
        window.onload = function() {
            <% if(isLoggedIn) { %>
                var bmiMarker = document.getElementById('bmiMarker');
                // Position based on BMI (18.5, 25, 30 are the thresholds)
                // Calculate position percentage
                var bmiValue = <%= bmi %>;
                var position = 0;
                
                if(bmiValue < 18.5) {
                    position = (bmiValue / 18.5) * 25;
                } else if(bmiValue < 25) {
                    position = 25 + ((bmiValue - 18.5) / 6.5) * 25;
                } else if(bmiValue < 30) {
                    position = 50 + ((bmiValue - 25) / 5) * 25;
                } else {
                    position = 75 + Math.min(((bmiValue - 30) / 10) * 25, 25);
                }
                
                // Ensure position is within bounds
                position = Math.max(0, Math.min(100, position));
                bmiMarker.style.left = position + '%';
            <% } %>
        };
    </script>
</body>
</html>

