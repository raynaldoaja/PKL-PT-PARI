<?php

class Paket {
    private $db;

    public function __construct(Database $database) {
        $this->db = $database->getConnection();
        $this->db_helper = $database; 
    }

    private function cleanInput($data) {
        return $this->db_helper->cleanInput($data);
    }
    
    // logika lacak.php
    public function trackByResi($nomor_resi) {
        $clean_resi = $this->cleanInput($nomor_resi);

        $query_paket = "SELECT * FROM v_paket_tracking WHERE nomor_resi = ?";
        
        return [
            
        ];
    }

    // logika tambah.php 
    public function isResiUnique($nomor_resi) {
        $clean_resi = $this->cleanInput($nomor_resi);
        
        $query = "SELECT id FROM paket WHERE nomor_resi = ?";
        
        return true; //return boolean
    }

    public function tambahPaket($data) {

        
        return true; 
    }
}