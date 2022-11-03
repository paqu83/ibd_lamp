<?php

namespace App\Models;

use CodeIgniter\Model;

class SubscribersModel extends Model {

    protected $table = 'subscribers';

    /**
     * table name
     */
    protected $primaryKey = "id";

    /**
     * allowed Field
     */
    protected $allowedFields = [
        'fname',
        'email'
    ];

    public function getSubscribers() {
        return $this->findAll();
    }
}