class VideoAttributes

  MEDICINE = "Medicine"
  SURGERY = "Surgery"
  ANESTHESIA = "Anesthesia"
  RADIOLOGY = "Radiology"
  PEDIATRICS = "Pediatrics"
  OBGYN = "Ob/gyn"
  OTHER = "Other"
  ALL = "All"
  PSYCH = "Psych"
  NEURO = "Neuro"

  @categories_by_id =  {
    '5uBE4uuTEMQ' => MEDICINE,
    'ta9KNbcq-KI' => MEDICINE,
    'azvTa06_LTo' => MEDICINE,
    'NRQ8WzCi0ds' => MEDICINE,
    'XGjB-tzdSlE' => MEDICINE,
    'T3xFzsgJBkU' => MEDICINE,
    '4fP7-XgSZnQ' => MEDICINE,
    'yoJzNL6XqkI' => MEDICINE,
    'wAMis_HNZWE' => MEDICINE,
    '3CyKCe8B894' => MEDICINE,
    'nopHyyI2vPY' => MEDICINE,
    'jzVBNyI9Ay8' => MEDICINE,
    'VACDx6QTJv4' => MEDICINE,
    '7w3F-U6j1yU' => MEDICINE,
    '63tXOFlDQS8' => MEDICINE,
    'A_lrwKVLNNE' => MEDICINE,
    'uRk6XVw4pnw' => MEDICINE,
    'lpHJP-oaLvI' => MEDICINE,
    'WF1s01ePXLI' => MEDICINE,
    'y5TZT1IaQns' => MEDICINE,
    'H-pajljT5qE' => MEDICINE,
    'az_PyTXFG9c' => MEDICINE,
    'Xq9LFn7ddj8' => MEDICINE,
    '9-j0T63pQsc' => MEDICINE,
    'DHxSE2Y3Bb4' => MEDICINE,
    'AO9Xg2Jn8Rg' => MEDICINE,
    'r0szxqTVGtY' => MEDICINE,
    '2jD0RXdNYas' => SURGERY,
    'o-dkb-YX3-E' => SURGERY,
    'Q0X2cP3C8R8' => SURGERY,
    '-1m87_1D_jc' => SURGERY,
    'UybrrVVOFCY' => ANESTHESIA,
    '8ZAN6vEuYjY' => RADIOLOGY,
    'oEmCcEio6nw' => RADIOLOGY,
    'F8TYLT0-5fs' => RADIOLOGY,
    'W_6v0v6tqCE' => RADIOLOGY,
    'DnBRarZKvoU' => RADIOLOGY,
    '7tDDDLqWnBQ' => RADIOLOGY,
    '4NNhGSXvbOU' => RADIOLOGY,
    '4oYBLkbDjhg' => RADIOLOGY,
    'z7_HseZBTT0' => RADIOLOGY,
    'iEPCWQ64-pc' => PEDIATRICS,
    'i0fnBTUuRIA' => PEDIATRICS,
    'xDlwAry1HHY' => OBGYN,
    'vpw0bKOTDrs' => OBGYN,
    'YO6TzRwzQFU' => OBGYN,
    'R6XGStFZz_Q' => OBGYN,
    '4x1DoKYZucE' => OBGYN,
    'MVDKrQorC4A' => PSYCH,
    '5O4eZT0J3l0' => NEURO,
    'eLqtVFbYwJc' => NEURO,
    'suAwmQaTmUE' => NEURO
  }

  @order_by_id =  {
      '5uBE4uuTEMQ' => 1,
      'ta9KNbcq-KI' => 2,
      'azvTa06_LTo' => 3,
      'NRQ8WzCi0ds' => 4,
      'XGjB-tzdSlE' => 5,
      'T3xFzsgJBkU' => 6,
      '4fP7-XgSZnQ' => 7,
      'yoJzNL6XqkI' => 8,
      'wAMis_HNZWE' => 9,
      '3CyKCe8B894' => 10,
      'nopHyyI2vPY' => 11,
      'jzVBNyI9Ay8' => 12,
      'VACDx6QTJv4' => 13,
      '7w3F-U6j1yU' => 14,
      '63tXOFlDQS8' => 15,
      'A_lrwKVLNNE' => 16,
      'uRk6XVw4pnw' => 17,
      'lpHJP-oaLvI' => 18,
      'WF1s01ePXLI' => 19,
      'y5TZT1IaQns' => 20,
      'H-pajljT5qE' => 21,
      'az_PyTXFG9c' => 22,
      'Xq9LFn7ddj8' => 23,
      '9-j0T63pQsc' => 24,
      'DHxSE2Y3Bb4' => 25,
      'AO9Xg2Jn8Rg' => 26,
      'r0szxqTVGtY' => 27,
      '2jD0RXdNYas' => 28,
      'o-dkb-YX3-E' => 29,
      'Q0X2cP3C8R8' => 30,
      '-1m87_1D_jc' => 31,
      'UybrrVVOFCY' => 32,
      '8ZAN6vEuYjY' => 33,
      'oEmCcEio6nw' => 34,
      'F8TYLT0-5fs' => 35,
      'W_6v0v6tqCE' => 36,
      'DnBRarZKvoU' => 37,
      '7tDDDLqWnBQ' => 38,
      '4NNhGSXvbOU' => 39,
      '4oYBLkbDjhg' => 40,
      'z7_HseZBTT0' => 41,
      'iEPCWQ64-pc' => 42,
      'i0fnBTUuRIA' => 43,
      'xDlwAry1HHY' => 44,
      'vpw0bKOTDrs' => 45,
      'YO6TzRwzQFU' => 46,
      'R6XGStFZz_Q' => 47,
      '4x1DoKYZucE' => 48,
      'MVDKrQorC4A' => 49,
      'eLqtVFbYwJc' => 50,
      'suAwmQaTmUE' => 51
  }


  def self.find_category(id)
      return @categories_by_id[id]
  end

  def self.find_order(id)
    return @order_by_id[id]
  end
end