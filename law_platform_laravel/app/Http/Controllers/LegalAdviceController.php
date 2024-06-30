<?php

namespace App\Http\Controllers;

use App\Models\AdviceType;
use App\Models\LegalAdvice;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LegalAdviceController extends Controller
{
    // Get all legal advices
    public function index()
    {
        $legalAdvices = LegalAdvice::with('adviceType')->get();

        $legalAdvicesData = $legalAdvices->map(function ($legalAdvice) {
            return [
                'id' => $legalAdvice->id,
                'member_id' => $legalAdvice->member_id,
                'advice_type_id' => $legalAdvice->advice_type_id,
                'type' => $legalAdvice->adviceType->name,
                'text' => $legalAdvice->text,
                'image' => $legalAdvice->image,
                'date' => $legalAdvice->date,
                'comments_count' => $legalAdvice->comments_count,
            ];
        });

        return response()->json([
            'status' => true,
            'data' => $legalAdvicesData
        ]);
    }

    // Get legal advices by advice type
    public function getByAdviceType($adviceTypeId)
    {
        $adviceType = AdviceType::findOrFail($adviceTypeId);
        $legalAdvices = $adviceType->legalAdvices()->with('adviceType')->get();

        $legalAdvicesData = $legalAdvices->map(function ($legalAdvice) {
            return [
                'id' => $legalAdvice->id,
                'member_id' => $legalAdvice->member_id,
                'advice_type_id' => $legalAdvice->advice_type_id,
                'type' => $legalAdvice->adviceType->name,
                'text' => $legalAdvice->text,
                'image' => $legalAdvice->image,
                'date' => $legalAdvice->date,
                'comments_count' => $legalAdvice->comments_count,
            ];
        });

        return response()->json([
            'status' => true,
            'data' => $legalAdvicesData
        ]);
    }

    // Add a legal advice
    public function store(Request $request)
    {
        $request->validate([
            'advice_type_id' => 'required|exists:advice_types,id',
            'text' => 'required|string',
            'image' => 'nullable|image|max:2048',
        ]);

        $imagePath = $request->hasFile('image') ? $request->file('image')->store('legal_advices_images', 'public') : null;

        $member = Auth::user();

        $legalAdvice = LegalAdvice::create([
            'member_id' => $member->id,
            'advice_type_id' => $request->input('advice_type_id'),
            'text' => $request->input('text'),
            'image' => $imagePath,
            'date' => now(), // Set the current timestamp
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Legal advice added successfully',
            'data' => $legalAdvice
        ]);
    }

    // Get specific legal advice by ID
    public function show($id)
    {
        $legalAdvice = LegalAdvice::with(['adviceType', 'comments'])->findOrFail($id);

        return response()->json([
            'status' => true,
            'data' => [
                'id' => $legalAdvice->id,
                'member_id' => $legalAdvice->member_id,
                'advice_type_id' => $legalAdvice->advice_type_id,
                'type' => $legalAdvice->adviceType->name,
                'text' => $legalAdvice->text,
                'image' => $legalAdvice->image,
                'date' => $legalAdvice->date,
                'comments_count' => $legalAdvice->comments_count,
                //'comments' => $legalAdvice->comments, // Optionally include comments if needed
            ]
        ]);
    }

    // Update a legal advice
    public function update(Request $request, $id)
    {
        $legalAdvice = LegalAdvice::findOrFail($id);

        // Check if the authenticated user is the owner of the legal advice
        if ($legalAdvice->member_id !== Auth::id()) {
            return response()->json([
                'status' => false,
                'message' => 'Unauthorized'
            ], 403);
        }

        $request->validate([
            'advice_type_id' => 'required|exists:advice_types,id',
            'text' => 'required|string',
            'image' => 'nullable|image|max:2048',
        ]);

        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('legal_advices_images', 'public');
        }

        $legalAdvice->update([
            'advice_type_id' => $request->input('advice_type_id'),
            'text' => $request->input('text'),
            'image' => $request->hasFile('image') ? $imagePath : $legalAdvice->image,
            'date' => now(), // Update the timestamp to the current time
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Legal advice updated successfully',
            'data' => $legalAdvice
        ]);
    }

    // Delete a legal advice
    public function destroy($id)
    {
        $legalAdvice = LegalAdvice::findOrFail($id);

        // Check if the authenticated user is the owner of the legal advice
        if ($legalAdvice->member_id !== Auth::id()) {
            return response()->json([
                'status' => false,
                'message' => 'Unauthorized'
            ], 403);
        }

        $legalAdvice->delete();

        return response()->json([
            'status' => true,
            'message' => 'Legal advice deleted successfully'
        ]);
    }
}
