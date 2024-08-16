<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class CommentNotification extends Notification implements ShouldQueue
{
    use Queueable;

    protected $commenter;
    protected $commentable; // Could be a post or legal advice

    public function __construct($commenter, $commentable)
    {
        $this->commenter = $commenter;
        $this->commentable = $commentable;
    }

    public function via($notifiable)
    {
        return ['database'];
    }

    public function toDatabase($notifiable)
    {
        return [
            'commenter_id' => $this->commenter->id,
            'commenter_name' => $this->commenter->name,
            'commentable_id' => $this->commentable->id,
            'commentable_type' => get_class($this->commentable),
            'commentable_title' => $this->commentable->title ?? 'No Title',
            'message' => "{$this->commenter->name} commented on your {$this->commentable->type}"
        ];
    }
}
