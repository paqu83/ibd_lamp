<?php

namespace App\Controllers;

use CodeIgniter\Exceptions\PageNotFoundException;

class Pages extends BaseController {

    public function index() {
        return view('welcome_message');
    }

    public function view($page = 'home') {
        die('nice');
        $stop = 1;
        if (! is_file(APPPATH . 'Views/pages/' . $page . '.php')) {
            // Whoops, we don't have a page for that!
            throw new PageNotFoundException($page);
        }

        $data['title'] = ucfirst($page); // Capitalize the first letter

        return view('templates/header', $data)
            . view('pages/' . $page)
            . view('templates/footer');
    }

    public function zadanie_2($action = 'list') : mixed {
        $content['title'] = 'Zadanie 2';
        if (! is_file(APPPATH . 'Views/pages/zad_2_' . $action . '.php')) {
            // Whoops, we don't have a page for that!
            throw new PageNotFoundException($action);
        }

        if ($action === 'list') {
            $this->zadanie_2_list($content);
        }
        return view('templates/header', $content)
            . view('pages/zad_2_' . $action, $content)
            . view('templates/footer');
    }

    private function zadanie_2_list(&$content) : void {
        $model = model(SubscribersModel::class);
        $content['list'] = $model->getSubscribers();
    }

    public function zadanie_2_add() : mixed {
        $content['title'] = 'Add new subscriber';
        $content['action'] = '/zadanie_2/add';
        $model = model(SubscribersModel::class);

        if ($this->request->getMethod() === 'post' && $this->validate([
                'fname' => 'trim|required|min_length[3]|max_length[255]',
                'email'  => 'trim|required|valid_email|min_length[3]|max_length[255]',
            ])) {
            $model->save([
                'fname' => $this->request->getPost('fname'),
                'email'  => $this->request->getPost('email'),
            ]);

            return redirect()->to('/zadanie_2');
        }
        return view('templates/header', $content)
            . view('pages/zad_2_edit', $content)
            . view('templates/footer');
    }

    public function zadanie_2_edit($id) : mixed {
        $content['title'] = 'Edit  new subscriber id ' . $id;
        $content['action'] = '/zadanie_2/edit/' . $id;
        $model = model(SubscribersModel::class);

        $content['subscriber'] = $model->find($id);
        if (is_null($content['subscriber'])) {
            throw new PageNotFoundException($id);
        }

        if ($this->request->getMethod() === 'post' && $this->validate([
                'fname' => 'trim|required|min_length[3]|max_length[255]',
                'email'  => 'trim|required|valid_email|min_length[3]|max_length[255]',
            ])) {
            $model->update($id, [
                'fname' => $this->request->getPost('fname'),
                'email'  => $this->request->getPost('email'),
            ]);

            return redirect()->to('/zadanie_2');
        }
        return view('templates/header', $content)
            . view('pages/zad_2_edit', $content)
            . view('templates/footer');
    }

    public function zadanie_2_delete($id) : mixed {
        $content['title'] = 'Delete subscriber id ' . $id;
        $content['action'] = '/zadanie_2/delete/' . $id;
        $model = model(SubscribersModel::class);

        $content['subscriber'] = $model->find($id);
        if (is_null($content['subscriber'])) {
            throw new PageNotFoundException($id);
        }

        if ($this->request->getMethod() === 'post') {
            $model->delete($id);
            return redirect()->to('/zadanie_2');
        }
        return view('templates/header', $content)
            . view('pages/zad_2_delete', $content)
            . view('templates/footer');
    }

    public function zadanie_3() : mixed {
        $content['title'] = 'Zadanie 3';
        $db = \Config\Database::connect();
        $views = [
            'subscribers_added',
            'subscribers_deleted',
            'subscribers_deleted_added',
            'subscribers_edited',
            'subscribers_all',
        ];
        foreach ($views as $view_name) {
            $query   = $db->query('SELECT * FROM `' . $view_name . '`');
            $content['results'][$view_name] = $query->getResult('array');
        }

        return view('templates/header', $content)
            . view('pages/zad_3_list', $content)
            . view('templates/footer');
    }

    public function projekt() : mixed {
        $db = \Config\Database::connect();
        $content = [];
        $query   = $db->query('SELECT * FROM `history`');
        $content['results'] = $query->getResult('array');
        $content['chart'] = 'eur/pln'; // | 'usd/pln'
        if ($this->request->getMethod() === 'post') {
            $content['chart'] = $this->request->getPost('chart');

        }
        return view('pages/projekt', $content);
    }

}