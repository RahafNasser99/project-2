<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class InteractionNotification extends Notification implements ShouldQueue
{
    use Queueable;

    private $interactor;
    private $post;

    public function __construct($interactor, $post)
    {
        $this->interactor = $interactor;
        $this->post = $post;
    }

    public function via($notifiable)
    {
        return ['database'];
    }

    public function toDatabase($notifiable)
    {
        return [
            'interactor_id' => $this->interactor->id,
            'interactor_name' => $this->interactor->name,
            'post_id' => $this->post->id,
            'message' => "{$this->interactor->name} interacted with your post"
        ];
    }
}
